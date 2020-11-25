import React, { useEffect } from 'react';
import { useParams } from 'react-router-dom';
import { useSelector, useDispatch } from 'react-redux';
import styled from 'styled-components';
import {
  refreshVolumesAction,
  stopRefreshVolumesAction,
  refreshPersistentVolumesAction,
  stopRefreshPersistentVolumesAction,
  fetchPersistentVolumeClaimAction,
} from '../ducks/app/volumes';
import {
  refreshAlertsAction,
  stopRefreshAlertsAction,
  refreshCurrentVolumeStatsAction,
  stopRefreshCurrentVolumeStatsAction,
  fetchVolumeStatsAction,
} from '../ducks/app/monitoring';
import VolumeListTable from '../components/VolumeListTable';
import { getVolumeListData } from '../services/NodeVolumesUtils';
import { useRefreshEffect } from '../services/utils';
import { fontSize, padding } from '@scality/core-ui/dist/style/theme';

// Custom Volumes styling instead of the CommonLayout one because the volumes table component has inner scroll
export const NodesVolumesTab = styled.div`
  background-color: ${(props) => props.theme.brand.primary};
  color: ${(props) => props.theme.brand.textPrimary};
  padding-bottom: ${padding.base};
  height: calc(100vh - 172px);
  overflow: hidden;
`;

const TabContent = styled.div`
  height: 78vh;
  .sc-progressbarcontainer {
    font-size: ${fontSize.small};
  }
`;

const NodePageVolumesTab = (props) => {
  const { name } = useParams();
  const dispatch = useDispatch();

  const volumeListData = useSelector((state) =>
    getVolumeListData(state, null, name),
  );

  useRefreshEffect(refreshVolumesAction, stopRefreshVolumesAction);
  useRefreshEffect(
    refreshCurrentVolumeStatsAction,
    stopRefreshCurrentVolumeStatsAction,
  );
  useRefreshEffect(
    refreshPersistentVolumesAction,
    stopRefreshPersistentVolumesAction,
  );
  useEffect(() => {
    dispatch(fetchVolumeStatsAction());
    dispatch(fetchPersistentVolumeClaimAction());
  }, [dispatch]);
  useEffect(() => {
    dispatch(refreshAlertsAction());
    return () => dispatch(stopRefreshAlertsAction());
  }, [dispatch]);

  return (
    <NodesVolumesTab>
      <TabContent>
        <VolumeListTable
          volumeListData={volumeListData}
          isNodeColumn={false}
          isSearchBar={false}
          nodeName={name}
        ></VolumeListTable>
      </TabContent>
    </NodesVolumesTab>
  );
};

export default NodePageVolumesTab;
