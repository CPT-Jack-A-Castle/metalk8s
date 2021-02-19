import React, { useEffect } from 'react';
import { useSelector, useDispatch } from 'react-redux';
import { ThemeProvider } from 'styled-components';
import { useRouteMatch, useHistory } from 'react-router';
import { Switch } from 'react-router-dom';
import { Layout as CoreUILayout, Notifications } from '@scality/core-ui';

import { intl } from '../translations/IntlGlobalProvider';
import NodeCreateForm from './NodeCreateForm';
import NodePage from './NodePage';
import SolutionList from './SolutionList';
import EnvironmentCreationForm from './EnvironmentCreationForm';
import NodeDeployment from './NodeDeployment';
import ClusterMonitoring from './ClusterMonitoring';
import About from './About';
import PrivateRoute from './PrivateRoute';
import SolutionDetail from './SolutionDetail';
import VolumePage from './VolumePage';

import { toggleSideBarAction } from '../ducks/app/layout';

import { removeNotificationAction } from '../ducks/app/notifications';
import CreateVolume from './CreateVolume';
import { fetchClusterVersionAction } from '../ducks/app/nodes';
import { Navbar } from '../components/Navbar';

const Layout = (props) => {
  const sidebar = useSelector((state) => state.app.layout.sidebar);
  const { theme } = useSelector((state) => state.config);
  const notifications = useSelector((state) => state.app.notifications.list);
  const isUserLoaded = useSelector((state) => !!state.oidc.user);
  const dispatch = useDispatch();

  const removeNotification = (uid) => dispatch(removeNotificationAction(uid));
  const toggleSidebar = () => dispatch(toggleSideBarAction());
  const history = useHistory();

  useEffect(() => {
    dispatch(fetchClusterVersionAction());
  }, [dispatch]);

  const sidebarConfig = {
    onToggleClick: toggleSidebar,
    expanded: sidebar.expanded,
    'data-cy-state-isexpanded': sidebar.expanded,
    actions: [
      {
        label: intl.translate('alerts'),
        icon: <i className="fas fa-desktop" />,
        onClick: () => {
          history.push('/');
        },
        active: useRouteMatch({
          path: '/',
          exact: true,
          strict: true,
        }),
        'data-cy': 'sidebar_item_alerts',
      },
      {
        label: intl.translate('nodes'),
        icon: <i className="fas fa-server" />,
        onClick: () => {
          history.push('/nodes');
        },
        active: useRouteMatch({
          path: '/nodes',
          exact: false,
          strict: true,
        }),
        'data-cy': 'sidebar_item_nodes',
      },
      {
        label: intl.translate('volumes'),
        icon: <i className="fas fa-database" />,
        onClick: () => {
          history.push('/volumes');
        },
        active: useRouteMatch({
          path: '/volumes',
          exact: false,
          strict: true,
        }),
        'data-cy': 'sidebar_item_volumes',
      },
      {
        label: intl.translate('environments'),
        icon: <i className="fas fa-th" />,
        onClick: () => {
          history.push('/environments');
        },
        active: useRouteMatch({
          path: '/environments',
          exact: false,
          strict: true,
        }),
        'data-cy': 'sidebar_item_environments',
      },
    ],
  };

  return (
    <ThemeProvider theme={theme}>
      <CoreUILayout sidebar={isUserLoaded && sidebarConfig} navbarElement={<Navbar />}>
        <Notifications
          notifications={notifications}
          onDismiss={removeNotification}
        />
        <Switch>
          <PrivateRoute exact path="/nodes/create" component={NodeCreateForm} />
          <PrivateRoute
            exact
            path="/nodes/:id/deploy"
            component={NodeDeployment}
          />
          <PrivateRoute
            path={`/nodes/:id/createVolume`}
            component={CreateVolume}
          />
          <PrivateRoute
            exact
            path="/volumes/createVolume"
            component={CreateVolume}
          />
          <PrivateRoute path="/nodes" component={NodePage} />
          <PrivateRoute exact path="/environments" component={SolutionList} />
          <PrivateRoute path="/volumes/:name?" component={VolumePage} />
          <PrivateRoute
            exact
            path="/environments/create-environment"
            component={EnvironmentCreationForm}
          />
          <PrivateRoute exact path="/about" component={About} />
          <PrivateRoute exact path="/" component={ClusterMonitoring} />
          <PrivateRoute
            exact
            path="/environments/:id"
            component={SolutionDetail}
          />
        </Switch>
      </CoreUILayout>
    </ThemeProvider>
  );
};

export default Layout;
