//@flow
import React, { useContext } from 'react';
import { useLayoutEffect, type Node } from 'react';
import { Loader, ErrorPage500 } from '@scality/core-ui';
import { ConfigContext, useConfig } from './ConfigProvider';

/**
 * This hook dynamically load Platform library.
 *
 * @param {string} src library bundle url
 */
function useLoadPlatformLibrary(src?: string) {
  const configContext = useContext(ConfigContext);
  if (!configContext) {
    throw new Error('Config context is not defined');
  }

  const { platformLibraryStatus, setPlatformLibraryStatus } = configContext;

  useLayoutEffect(() => {
    if (platformLibraryStatus !== 'success') {
      setPlatformLibraryStatus('loading');
      const body = document.body;

      const element = [...(body?.querySelectorAll('script') || [])].find(
        // $FlowIssue
        (scriptElement) => scriptElement.attributes.src?.value === src,
      );

      if (!element && body && src) {
        const scriptElement = document.createElement('script');
        scriptElement.src = src;
        scriptElement.onerror = () => {
          setPlatformLibraryStatus('error');
        };
        scriptElement.onload = () => {
          setPlatformLibraryStatus('success');
        };
        body.appendChild(scriptElement);
      }
    }
  }, [src, platformLibraryStatus, setPlatformLibraryStatus]);

  if (platformLibraryStatus === 'error') {
    throw new Error(`Failed to load library ${src || ''}`);
  }

  return platformLibraryStatus;
}

export class PlatformLibraryNotAvailable extends Error {
  constructor() {
    super('Platform library is not available');
  }
}

export function usePlatformLibrary() {
  const {
    platformLibrary: { version: platformVersion },
  } = useConfig();

  if (window.shellUIPlatform && window.shellUIPlatform[platformVersion]) {
    return window.shellUIPlatform[platformVersion];
  }

  throw new PlatformLibraryNotAvailable();
}

export const PlatformLibraryProvider = ({
  children,
}: {
  children: Node,
}): Node => {
  const { platformLibrary } = useConfig();

  const status = useLoadPlatformLibrary(platformLibrary.url);

  switch (status) {
    case 'idle':
    case 'loading':
      return <Loader />;
    case 'success':
      return <>{children}</>;
    case 'error':
    default:
      return <ErrorPage500 data-cy="sc-error-page500" />;
  }
};
