//@flow

import React from 'react';
import { useQuery } from 'react-query';
import styled, { css } from 'styled-components';
import { Card, Loader } from '@scality/core-ui';
import {
  padding,
  fontSize,
  fontWeight,
} from '@scality/core-ui/dist/style/theme';

import {
  useAlertLibrary,
  useHighestSeverityAlerts,
  highestAlertToStatus,
} from '../containers/AlertProvider';
import { intl } from '../translations/IntlGlobalProvider';
import { usePlatformLibrary } from '../containers/PlatformLibraryProvider';
import { useAuth } from '../containers/AuthProvider';
import { useConfig } from '../containers/ConfigProvider';
import { PageSubtitle } from '../components/style/CommonLayoutStyle';
import { STATUS_WARNING, STATUS_CRITICAL } from '../constants';

const InventoryContainer = styled.div`
  padding: 0px ${padding.small};
  display: flex;
  flex-direction: column;
  flex-grow: 1;
`;

const CardsWrapper = styled.div`
  display: flex;
  justify-content: space-around;
  font-size: ${fontSize.base};
  margin: ${padding.base} 0px;
`;

const InventoryIcon = styled.i`
  font-size: ${fontSize.larger};
  margin-right: ${padding.base};
  ${(props) => {
    switch (props.status) {
      case STATUS_WARNING:
        return css`
          color: ${props.theme.brand.statusWarning};
        `;
      case STATUS_CRITICAL:
        return css`
          color: ${props.theme.brand.statusCritical};
        `;

      default:
        return css`
          color: ${props.theme.brand.statusHealthy};
        `;
    }
  }}
`;

const InventoryValue = styled.span`
  font-size: ${fontSize.larger};
  font-weight: ${fontWeight.bold};
`;

const DashboardInventory = () => {
  const alertsLibrary = useAlertLibrary();
  const platformLibrary = usePlatformLibrary();
  const nodesAlerts = useHighestSeverityAlerts(
    alertsLibrary.getNodesAlertSelectors(),
  );
  const nodesStatus = highestAlertToStatus(nodesAlerts);
  const volumesAlerts = useHighestSeverityAlerts(
    alertsLibrary.getVolumesAlertSelectors(),
  );
  const volumesStatus = highestAlertToStatus(volumesAlerts);
  const auth = useAuth();
  const config = useConfig();

  const { data: volumesCount } = useQuery(
    platformLibrary.getVolumesCountQuery(config.url, auth?.id_token),
  );
  const { data: nodesCount } = useQuery(
    platformLibrary.getNodesCountQuery(config.url, auth?.id_token),
  );

  return (
    <InventoryContainer>
      <PageSubtitle aria-label="inventory">
        {intl.translate('inventory')}
      </PageSubtitle>
      <CardsWrapper>
        {(nodesCount || nodesCount === 0) && nodesStatus ? (
          <Card
            width="46%"
            headerBackgroundColor="backgroundLevel1"
            bodyBackgroundColor="backgroundLevel2"
            aria-label="nodes"
          >
            <Card.Header>
              <div>Nodes</div>
            </Card.Header>
            <Card.BodyContainer>
              <Card.Body>
                <InventoryIcon
                  className="fas fa-server"
                  status={nodesStatus}
                  aria-label={nodesStatus}
                />
                <InventoryValue aria-label={`${nodesCount} nodes`}>
                  {nodesCount}
                </InventoryValue>
              </Card.Body>
            </Card.BodyContainer>
          </Card>
        ) : (
          <Loader aria-label="loading" />
        )}
        {(volumesCount || volumesCount === 0) && volumesStatus ? (
          <Card
            width="46%"
            headerBackgroundColor="backgroundLevel1"
            bodyBackgroundColor="backgroundLevel2"
            aria-label="volumes"
          >
            <Card.Header>
              <div>Volumes</div>
            </Card.Header>
            <Card.BodyContainer>
              <Card.Body>
                <InventoryIcon
                  className="fas fa-hdd"
                  status={volumesStatus}
                  aria-label={volumesStatus}
                />
                <InventoryValue aria-label={`${volumesCount} volumes`}>
                  {volumesCount}
                </InventoryValue>
              </Card.Body>
            </Card.BodyContainer>
          </Card>
        ) : (
          <Loader aria-label="loading" />
        )}
      </CardsWrapper>
    </InventoryContainer>
  );
};

export default DashboardInventory;
