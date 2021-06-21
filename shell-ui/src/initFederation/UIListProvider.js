//@flow
import { createContext, useContext, type Node } from 'react';
import { useQuery } from 'react-query';
import Loader from '@scality/core-ui/dist/components/loader/Loader.component';
import ErrorPage500 from '@scality/core-ui/dist/components/error-pages/ErrorPage500.component';

const UIListContext = createContext(null);

export const useDeployedApps = (selectors?: {
  kind?: string,
  name?: string,
}): { kind: string, url: string, name: string, version: string }[] => {
  const uiListContext = useContext(UIListContext);
  if (!uiListContext) {
    throw new Error("Can't use useDeployedApps outside of UIListProvider");
  }

  if (selectors && uiListContext.uis) {
    return uiListContext.uis.filter((ui) => {
      return (
        ((selectors.kind && selectors.kind === ui.kind) || !selectors.kind) &&
        ((selectors.name && selectors.name === ui.name) || !selectors.name)
      );
    });
  }

  return uiListContext.uis || [];
};

export const UIListProvider = ({
  children,
  discoveryURL,
}: {
  children: Node,
  discoveryURL: string,
}): Node => {
  const { status, data } = useQuery('discoveredUIs', () => {
    return fetch(discoveryURL).then((r) => {
      if (r.ok) {
        return r.json();
      } else {
        return Promise.reject();
      }
    });
  });

  return (
    <UIListContext.Provider value={{ uis: data }}>
      {status === 'loading' ||
        (status === 'idle' && (
          <Loader size="massive" centered={true} aria-label="loading" />
        ))}
      {status === 'error' && <ErrorPage500 data-cy="sc-error-page500" />}
      {status === 'success' && children}
    </UIListContext.Provider>
  );
};
