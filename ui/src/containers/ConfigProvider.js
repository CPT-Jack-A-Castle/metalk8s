// @flow

import React, {
  type Context,
  type Node,
  createContext,
  useContext,
  useState,
} from 'react';
import { useQuery } from 'react-query';
import { type Config, fetchConfig } from '../services/api';
import { Loader, ErrorPage500 } from '@scality/core-ui';

type LibraryStatus = 'idle' | 'loading' | 'success' | 'error';

export const ConfigContext: Context<{
  config: Config,
  setPlatformLibraryStatus: (newStatus: LibraryStatus) => void,
  platformLibraryStatus: LibraryStatus,
} | null> = createContext(null);

export function useConfig(): Config {
  const config = useContext(ConfigContext);
  if (!config) {
    throw new Error(
      'config is undefined, this may be because you forgot to wrap your component with <ConfigProvider></ConfigProvider>',
    );
  }
  return config.config;
}

export function ConfigProvider({ children }: { children: Node }): Node {
  const { data: config, status } = useQuery('config', () => fetchConfig());
  const [platformLibraryStatus, setPlatformLibraryStatus] =
    useState<LibraryStatus>('idle');

  switch (status) {
    case 'idle':
    case 'loading':
      return <Loader />;
    case 'success':
      return (
        <ConfigContext.Provider
          value={{
            config,
            platformLibraryStatus,
            setPlatformLibraryStatus,
          }}
        >
          {children}
        </ConfigContext.Provider>
      );
    case 'error':
    default:
      return <ErrorPage500 data-cy="sc-error-page500" />;
  }
}
