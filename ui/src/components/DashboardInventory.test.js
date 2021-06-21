//@flow
import React from 'react';
import { screen } from '@testing-library/react';
import { setupServer } from 'msw/node';
import { rest } from 'msw';
import DashboardInventory from './DashboardInventory';
import {
  waitForLoadingToFinish,
  render,
  FAKE_CONTROL_PLANE_IP,
} from './__TEST__/util';
import type { Alert } from '../services/alertUtils';
import { useHighestSeverityAlerts } from '../containers/AlertProvider';
import { usePlatformLibrary } from '../containers/PlatformLibraryProvider';

const alertsCritical = [
  {
    id: 'alert1',
    severity: 'critical',
  },
];
const alertsWarning = [
  {
    id: 'alert2',
    severity: 'warning',
  },
];
const noAlerts = [];

jest.mock('../containers/ConfigProvider', () => ({
  __esModule: true, // Allows for the "default" import to work in the Mock injection
  default: ({ children }) => <>{children}</>,
  useConfig: () => ({
    url: 'mock.k8s.url',
  }),
}));

jest.mock('../containers/AuthProvider', () => ({
  __esModule: true,
  default: ({ children }) => <>{children}</>,
  useAuth: () => ({
    id_token: 'mock.token',
  }),
}));

jest.mock('../containers/PlatformLibraryProvider', () => ({
  __esModule: true,
  default: ({ children }) => <>{children}</>,
  usePlatformLibrary: jest.fn(),
}));

jest.mock('../containers/AlertProvider', () => ({
  __esModule: true, // this property makes it work
  default: ({ children }) => <>{children}</>,
  useHighestSeverityAlerts: jest.fn(),
  useAlertLibrary: () => ({
    getNodesAlertSelectors: () => {},
    getVolumesAlertSelectors: () => {},
  }),
  highestAlertToStatus: (alerts?: Alert[]): string => {
    return (alerts?.[0] && ((alerts[0].severity: any): string)) || 'healthy';
  },
}));

const server = setupServer(
  rest.get(
    `http://${FAKE_CONTROL_PLANE_IP}:8443/api/prometheus/api/v1/query`,
    (req, res, ctx) => {
      const result = {
        status: 'success',
        data: {
          resultType: 'vector',
          result: [
            {
              metric: {
                container: 'node-exporter',
                device: '/dev/vdc',
                endpoint: 'metrics',
                fstype: 'xfs',
                instance: '192.168.1.29:9100',
                job: 'node-exporter',
                mountpoint: '/mnt/testpart',
                namespace: 'metalk8s-monitoring',
                pod: 'prometheus-operator-prometheus-node-exporter-wk86s',
                service: 'prometheus-operator-prometheus-node-exporter',
              },
              value: [1611905929.203, '96.86575443786982'],
            },
          ],
        },
      };
      // return success status
      return res(ctx.json(result));
    },
  ),
);

describe('the dashboard inventory panel', () => {
  beforeAll(() => {
    server.listen();
    (usePlatformLibrary: any).mockImplementation(() => ({
      getVolumesCountQuery: () => ({
        queryKey: 'countVolumes',
        queryFn: () => 4,
      }),
      getNodesCountQuery: () => ({
        queryKey: 'countNodes',
        queryFn: () => 6,
      }),
    }));
  });

  test('displays the inventory card and nodes/volumes counts', async () => {
    // Render
    render(<DashboardInventory />);

    // Loading
    await waitForLoadingToFinish();

    // Verify
    expect(screen.getByLabelText('inventory')).toBeInTheDocument();
    expect(screen.getByLabelText('nodes')).toBeInTheDocument();
    expect(screen.getByLabelText('volumes')).toBeInTheDocument();
    expect(screen.getByLabelText('6 nodes')).toBeInTheDocument();
    expect(screen.getByLabelText('4 volumes')).toBeInTheDocument();
  });

  test('displays properly the status CRITICAL for nodes and volumes', async () => {
    // Have to any type jest.fn function to avoid Flow warning for mockImplementation()
    (useHighestSeverityAlerts: any).mockImplementation(() => alertsCritical);

    // Render
    render(<DashboardInventory />);

    // Loading
    await waitForLoadingToFinish();

    // Verify
    expect(screen.getAllByLabelText('critical').length).toEqual(2);
  });

  test('displays properly the status WARNING for nodes and volumes', async () => {
    // Have to any type jest.fn function to avoid Flow warning for mockImplementation()
    (useHighestSeverityAlerts: any).mockImplementation(() => alertsWarning);

    // Render
    render(<DashboardInventory />);

    // Loading
    await waitForLoadingToFinish();

    // Verify
    expect(screen.getAllByLabelText('warning').length).toEqual(2);
  });

  test('displays properly the status HEALTHY for nodes and volumes', async () => {
    // Have to any type jest.fn function to avoid Flow warning for mockImplementation()
    (useHighestSeverityAlerts: any).mockImplementation(() => noAlerts);

    // Render
    render(<DashboardInventory />);

    // Loading
    await waitForLoadingToFinish();

    // Verify
    expect(screen.getAllByLabelText('healthy').length).toEqual(2);
  });

  test('displays the loader if the query does not return a result', async () => {
    // Have to any type jest.fn function to avoid Flow warning for mockImplementation()
    (usePlatformLibrary: any).mockImplementation(() => ({
      getVolumesCountQuery: () => ({
        queryKey: 'countVolumes',
        queryFn: () => new Error('mock'),
      }),
      getNodesCountQuery: () => ({
        queryKey: 'countNodes',
        queryFn: () => new Error('mock'),
      }),
    }));

    // Render
    render(<DashboardInventory />);

    // Verify
    expect(screen.getAllByLabelText('loading').length).toEqual(2);
  });

  afterEach(() => server.resetHandlers());

  afterAll(() => {
    server.close();
  });
});
