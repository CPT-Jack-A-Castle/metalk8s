//@flow
import React, { useCallback } from 'react';
import styled, { useTheme } from 'styled-components';
import { useTable } from 'react-table';
import { useQuery } from 'react-query';
import { ProgressBar, Loader } from '@scality/core-ui';
import { fontSize, padding } from '@scality/core-ui/dist/style/theme';
import {
  queryNodeFSUsage,
  queryNodeFSSize,
} from '../services/prometheus/fetchMetrics';
import CircleStatus from './CircleStatus';
import { getAlerts } from '../services/alertmanager/api';
import { getNodePartitionsTableData } from '../services/NodeVolumesUtils';
import { intl } from '../translations/IntlGlobalProvider';

const HeadRow = styled.tr`
  width: 100%;
  /* To display scroll bar on the table */
  display: table;
  table-layout: fixed;
`;

const Body = styled.tbody`
  /* To display scroll bar on the table */
  display: block;
  overflow: auto;
`;

const SystemDeviceTableContainer = styled.div`
  color: ${(props) => props.theme.brand.textPrimary};
  padding: 1rem;
  font-family: 'Lato';
  font-size: ${fontSize.base};
  border-color: ${(props) => props.theme.brand.borderLight};
  table {
    border-spacing: 0;

    th {
      font-weight: bold;
      height: 56px;
      border-bottom: 1px solid ${(props) => props.theme.brand.border};
    }

    td {
      margin: 0;
      padding: 0.5rem;
      text-align: left;
      padding: 5px;
      height: 48px;
      border-bottom: 1px solid ${(props) => props.theme.brand.border};
      :last-child {
        border-right: 0;
      }
    }
    .sc-progressbarcontainer > div {
      background-color: ${(props) => props.theme.brand.secondaryDark1};
    }
  }
`;

const Cell = styled.td`
  overflow-wrap: break-word;
`;

const columns = [
  {
    Header: 'Health',
    accessor: 'health',
    cellStyle: { textAlign: 'center', width: '100px' },
    Cell: (cellProps) => {
      return (
        <CircleStatus className="fas fa-circle" status={cellProps.value} />
      );
    },
  },
  {
    Header: 'Partition path',
    accessor: 'partitionPath',
    cellStyle: { textAlign: 'left' },
  },
  {
    Header: 'Usage',
    accessor: 'usage',
    cellStyle: { textAlign: 'center' },
  },
  {
    Header: 'Size',
    accessor: 'size',
    cellStyle: { textAlign: 'right', width: '100px' },
  },
];

const LoaderContainer = styled.div`
  display: flex;
  justify-content: center;
`;
const NodePartitionTable = ({ instanceIP }: { instanceIP: string }) => {
  const theme = useTheme();
  const { data: partitions, status } = useQuery(
    ['nodeDevices', instanceIP],
    useCallback(
      () =>
        Promise.all([
          queryNodeFSUsage(instanceIP),
          queryNodeFSSize(instanceIP),
          getAlerts(),
        ]).then(([nodeFSUsageResult, nodeFSSizeResult, alerts]) => {
          if (
            nodeFSUsageResult.status === 'success' &&
            nodeFSSizeResult.status === 'success' &&
            nodeFSUsageResult.data.resultType === 'vector' &&
            nodeFSSizeResult.data.resultType === 'vector'
          ) {
            return getNodePartitionsTableData(
              nodeFSUsageResult.data.result,
              nodeFSSizeResult.data.result,
              alerts,
            );
          }
        }),
      [instanceIP],
    ),
  );

  const {
    getTableProps,
    getTableBodyProps,
    headerGroups,
    rows,
    prepareRow,
  } = useTable({
    columns,
    data: partitions || [],
  });

  return (
    <SystemDeviceTableContainer>
      <table {...getTableProps()}>
        <thead>
          {headerGroups.map((headerGroup) => {
            return (
              <HeadRow {...headerGroup.getHeaderGroupProps()}>
                {headerGroup.headers.map((column) => {
                  const headerStyleProps = column.getHeaderProps({
                    style: column.cellStyle,
                  });
                  return (
                    <th {...headerStyleProps}>{column.render('Header')}</th>
                  );
                })}
              </HeadRow>
            );
          })}
        </thead>
        <Body {...getTableBodyProps()}>
          {status === 'success' && partitions.length === 0 && (
            <HeadRow
              style={{
                width: '100%',
                paddingTop: padding.base,
                height: '60px',
              }}
            >
              <td
                style={{
                  textAlign: 'center',
                }}
              >
                {intl.translate('no_system_partition')}
              </td>
            </HeadRow>
          )}
          {status === 'loading' && (
            <HeadRow
              style={{
                width: '100%',
                paddingTop: padding.base,
                height: '60px',
              }}
            >
              <td
                style={{
                  width: '100%',
                  textAlign: 'center',
                }}
              >
                <LoaderContainer>
                  <Loader size="large" />
                </LoaderContainer>
              </td>
            </HeadRow>
          )}
          {status === 'error' && (
            <HeadRow
              style={{
                width: '100%',
                paddingTop: padding.base,
                height: '60px',
              }}
            >
              <td
                style={{
                  width: '100%',
                  textAlign: 'center',
                }}
              >
                {intl.translate('error_loading_partitions')}
              </td>
            </HeadRow>
          )}
          {rows.map((row, i) => {
            prepareRow(row);
            return (
              <HeadRow {...row.getRowProps()}>
                {row.cells.map((cell) => {
                  let cellProps = cell.getCellProps({
                    style: { ...cell.column.cellStyle },
                  });
                  if (cell.column.Header === 'Usage') {
                    return (
                      <Cell {...cellProps}>
                        <ProgressBar
                          size="large"
                          percentage={cell.value}
                          buildinLabel={`${cell.value}%`}
                          backgroundColor={theme.brand.primaryDark1}
                        />
                      </Cell>
                    );
                  }
                  return <Cell {...cellProps}>{cell.render('Cell')}</Cell>;
                })}
              </HeadRow>
            );
          })}
        </Body>
      </table>
    </SystemDeviceTableContainer>
  );
};

export default NodePartitionTable;
