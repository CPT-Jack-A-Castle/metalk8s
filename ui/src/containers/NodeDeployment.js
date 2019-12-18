import React, { useEffect, useState } from 'react';
import { useSelector, useDispatch } from 'react-redux';
import styled from 'styled-components';
import ReactJson from 'react-json-view';
import { Button, Loader, Steppers } from '@scality/core-ui';
import { useRouteMatch, useHistory } from 'react-router';

import { subscribeDeployEventsAction } from '../ducks/app/nodes';
import { getJobStatusFromEventRet } from '../../src/services/salt/utils';
import {
  fontWeight,
  grayLighter,
  padding,
  fontSize,
} from '@scality/core-ui/dist/style/theme';
import { intl } from '../translations/IntlGlobalProvider';

const NodeDeploymentContainer = styled.div`
  height: 100%;
  display: flex;
  flex-direction: column;
  padding: ${padding.larger};
  overflow: auto;
`;

const NodeDeploymentTitle = styled.div`
  color: ${props => props.theme.brand.text};
  font-weight: ${fontWeight.bold};
  font-size: ${fontSize.large};
  margin: ${padding.base};
`;

const NodeDeploymentEvent = styled.div`
  background-color: ${grayLighter};
  color: ${props => props.theme.brand.text} !important;
  padding: ${padding.base};
  margin: ${padding.base};
  border-radius: 5px;
  display: flex;
  flex-grow: 1;
`;

const NodeDeploymentContent = styled.div`
  display: flex;
`;

const NodeDeploymentWrapper = styled.div`
  padding: ${padding.base};
`;

const NodeDeploymentStatus = styled.div`
  padding: ${padding.larger};
  width: 400px;
`;

const ErrorLabel = styled.span`
  color: ${props => props.theme.brand.danger};
`;

const NodeDeployment = () => {
  const dispatch = useDispatch();
  const history = useHistory();
  const match = useRouteMatch();
  const nodeId = match?.params?.id;

  const events = useSelector(state => {
    if (nodeId) {
      return state.app.nodes.events[nodeId] || [];
    }
    return [];
  });

  const [activeStep, setActiveStep] = useState(1);
  const [steps, setSteps] = useState([
    { title: intl.translate('node_registered') },
    { title: intl.translate('deploying'), content: <Loader size="larger" /> },
  ]);

  useEffect(() => {
    if (nodeId) {
      const subscribeDeployEvents = jid =>
        dispatch(subscribeDeployEventsAction(jid));
      subscribeDeployEvents(nodeId);
    }
  }, [nodeId, dispatch]);

  useEffect(() => {
    if (
      //To improve
      !steps.find(
        step => step.title === intl.translate('deployment_started'),
      ) &&
      events.find(event => event.tag.includes('/new'))
    ) {
      const newSteps = steps;
      newSteps.splice(steps.length - 1, 0, {
        title: intl.translate('deployment_started'),
      });
      setSteps(newSteps);
      setActiveStep(2);
    }

    const result = events.find(event => event.tag.includes('/ret'));
    if (result) {
      const status = getJobStatusFromEventRet(result.data);
      const newSteps = steps;
      newSteps.splice(steps.length - 1, 1, {
        title: intl.translate('completed'),
        content: (
          <span>
            {!status.success && (
              <ErrorLabel>
                {`${intl.translate('error')}: ${status.step_id} - ${
                  status.comment
                }`}
              </ErrorLabel>
            )}
          </span>
        ),
      });
      setSteps(newSteps);
      setActiveStep(status.success ? steps.length : steps.length - 1);
    }
  }, [events, steps]);

  return (
    <NodeDeploymentContainer>
      <div>
        <Button
          text={intl.translate('back_to_node_list')}
          type="button"
          outlined
          onClick={() => history.push('/nodes')}
          icon={<i className="fas fa-arrow-left" />}
        />
      </div>
      <NodeDeploymentWrapper>
        <NodeDeploymentTitle>
          {intl.translate('node_deployment')}
        </NodeDeploymentTitle>
        <NodeDeploymentContent>
          <NodeDeploymentStatus>
            <Steppers steps={steps} activeStep={activeStep} />
          </NodeDeploymentStatus>
          <NodeDeploymentEvent>
            <ReactJson src={events} name={nodeId} collapsed={true} />
          </NodeDeploymentEvent>
        </NodeDeploymentContent>
      </NodeDeploymentWrapper>
    </NodeDeploymentContainer>
  );
};

export default NodeDeployment;