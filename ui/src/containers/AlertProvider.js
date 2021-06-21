//@flow
import React, {
  type Node,
  useLayoutEffect,
  createContext,
  useContext,
  useState,
  useRef,
} from 'react';
import { useQuery } from 'react-query';
import { useTypedSelector } from '../hooks';
import { ErrorBoundary } from 'react-error-boundary';
import type { FilterLabels, Alert } from '../services/alertUtils';
import { ErrorPage500 } from '@scality/core-ui';
import { useConfig } from './ConfigProvider';
import { STATUS_HEALTH } from '../constants';

export type Status = 'healthy' | 'warning' | 'critical';

export const useAlerts = (filters: FilterLabels) => {
  const { alerts_lib_version } = useConfig();

  if (window.shellUIAlerts && window.shellUIAlerts[alerts_lib_version]) {
    return window.shellUIAlerts[alerts_lib_version].useAlerts(useContext)(
      filters,
    );
  }
};

export const useHighestSeverityAlerts = (filters: FilterLabels) => {
  const { alerts_lib_version } = useConfig();

  if (window.shellUIAlerts && window.shellUIAlerts[alerts_lib_version]) {
    return window.shellUIAlerts[alerts_lib_version].useHighestSeverityAlerts(
      useContext,
      filters,
    );
  }
};

export const highestAlertToStatus = (alerts?: Alert[]): Status => {
  return (alerts?.[0] && ((alerts[0].severity: any): Status)) || STATUS_HEALTH;
};

/**
 * This hook dynamically load Alert library.
 *
 * It first creates a script entry if none exists referring the given library src
 *  and then initiates the library by calling `createAlertContext`
 *
 * @param {string} src library bundle url
 * @param {string?} version library version
 */
function useLoadAlertLibrary(src?: string, version?: string) {
  const [hasFailed, setHasFailed] = useState(false);
  useLayoutEffect(() => {
    const body = document.body;
    // $flow-disable-line
    const element = [...(body?.querySelectorAll('script') || [])].find(
      // $flow-disable-line
      (scriptElement) => scriptElement.attributes.src?.value === src,
    );

    if (!element && body && src && version) {
      const scriptElement = document.createElement('script');
      scriptElement.src = src;
      scriptElement.onerror = () => {
        setHasFailed(true);
      };
      scriptElement.onload = () => {
        window.shellUIAlerts[version].createAlertContext(createContext);
      };
      body.appendChild(scriptElement);
    }
  }, [src, version]);

  if (hasFailed) {
    throw new Error(`Failed to load library ${src || ''}`);
  }
}

export class AlertLibraryNotAvailable extends Error {
  constructor() {
    super('Platform library is not available');
  }
}

export function useAlertLibrary() {
  const { alerts_lib_version } = useConfig();

  if (window.shellUIAlerts && window.shellUIAlerts[alerts_lib_version]) {
    return window.shellUIAlerts[alerts_lib_version];
  }

  throw new AlertLibraryNotAvailable();
}

const InternalAlertProvider = ({ children }: { children: Node }): Node => {
  const { url_alertmanager, url_alerts, alerts_lib_version } = useConfig();

  useLoadAlertLibrary(url_alerts, alerts_lib_version);

  const AlertProviderRef = useRef(null);

  // In order to avoid react to uselessly rerender children every time we move
  // the AlertProvider to a ref and renders it only a single time once the library is ready.
  if (
    window.shellUIAlerts &&
    window.shellUIAlerts[alerts_lib_version] &&
    !AlertProviderRef.current
  ) {
    AlertProviderRef.current =
      window.shellUIAlerts[alerts_lib_version].AlertProvider(useQuery);
  }

  if (AlertProviderRef.current) {
    return (
      <AlertProviderRef.current alertManagerUrl={url_alertmanager}>
        {children}
      </AlertProviderRef.current>
    );
  }

  return <>{children}</>;
};

function ErrorFallback() {
  const { language, api } = useTypedSelector((state) => state.config);
  const url_support = api?.url_support;
  return (
    <ErrorPage500
      data-cy="sc-error-page500"
      locale={language}
      supportLink={url_support}
    />
  );
}

const AlertProvider = ({ children }: { children: Node }): Node => {
  return (
    <ErrorBoundary FallbackComponent={ErrorFallback}>
      <InternalAlertProvider>{children}</InternalAlertProvider>
    </ErrorBoundary>
  );
};

export default AlertProvider;
