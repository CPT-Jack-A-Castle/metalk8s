//@flow
import CoreUINavbar from '@scality/core-ui/dist/components/navbar/Navbar.component';
import Dropdown from '@scality/core-ui/dist/components/dropdown/Dropdown.component';
import { type Item as CoreUIDropdownItem } from '@scality/core-ui/src/lib/components/dropdown/Dropdown.component';
import { useAuth } from 'oidc-react';
import { useLayoutEffect, useState } from 'react';
import styled from 'styled-components';
import type {
  Options,
  SolutionsNavbarProps,
  PathDescription,
  UserGroupsMapping,
} from './index';
import type { Node } from 'react';
import { logOut } from './auth/logout';
import {
  getAccessiblePathsFromOptions,
  getUserGroups,
  isEntryAccessibleByTheUser,
  normalizePath,
} from './auth/permissionUtils';
import { prefetch } from 'quicklink';
import { useTheme } from 'styled-components';
import { useLanguage } from './lang';
import { useThemeName } from './theme';
import { useIntl } from 'react-intl';

const Logo = styled.img`
  height: 30px;
`;

export const LoadingNavbar = ({ logo }: { logo: string }): Node => (
  <CoreUINavbar
    logo={<Logo src={logo} alt="logo" />}
    role="navigation"
    tabs={[{ title: 'loading' }]}
  />
);

const translateOptionsToMenu = (
  options: Options,
  section: 'main' | 'subLogin',
  renderer: (
    path: string,
    pathDescription: PathDescription,
  ) => { link: Node } | { label: string, onClick: () => void },
  userGroups: string[],
) => {
  const normalizedLocation = normalizePath(location.href);
  const entries = Object.entries(options[section])
    //$FlowIssue - flow typing for Object.entries incorrectly typing values as [string, mixed] instead of [string, PathDescription]
    .filter((entry: [string, PathDescription]) =>
      isEntryAccessibleByTheUser(entry, userGroups),
    );
  entries.sort(([_, entryA], [__, entryB]) => ((entryA.order || Infinity) < (entryB.order || Infinity) ? -1 : 1));
  return entries.map(
    //$FlowIssue - flow typing for Object.entries incorrectly typing values as [string, mixed] instead of [string, PathDescription]
    ([path, pathDescription]: [string, PathDescription], i) => {
      try {
        return {
          ...renderer(path, pathDescription),
          selected: pathDescription.activeIfMatches
            ? new RegExp(pathDescription.activeIfMatches).test(location.href)
            : normalizedLocation === normalizePath(path),
        };
      } catch (e) {
        throw new Error(
          `[navbar][config] Invalid path specified in "options.${section}": "${path}" ` +
            '(keys must be defined as fully qualified URLs, ' +
            'such as "{protocol}://{host}{path}?{queryParams}")',
        );
      }
    },
  );
};

const NavbarDropDownItem = styled.div`
  display: flex;
  width: 200px;
  align-items: center;
`;

const NavbarDropDownItemIcon = styled.div`
  padding-right: 10px;
  color: ${(props) => props.theme.textSecondary};
`;

const NavbarDropDownItemLabel = styled.div`
  flex-grow: 1;
`;

const NavbarDropDownItemExternal = styled.div`
  padding-left: 10px;
  color: ${(props) => props.theme.secondary};
`;

const Item = ({
  icon,
  label,
  isExternal,
}: {
  icon?: string,
  label: string,
  isExternal?: boolean,
}) => {
  const brand = useTheme();
  return (
    <NavbarDropDownItem>
      {icon && (
        <NavbarDropDownItemIcon>
          <i className={icon} />
        </NavbarDropDownItemIcon>
      )}
      <NavbarDropDownItemLabel>{label}</NavbarDropDownItemLabel>
      {isExternal && (
        <NavbarDropDownItemExternal>
          <i className="fas fa-external-link-alt" />
        </NavbarDropDownItemExternal>
      )}
    </NavbarDropDownItem>
  );
};

export const Navbar = ({
  options,
  logo,
  userGroupsMapping,
  canChangeLanguage,
  canChangeTheme,
  providerLogout,
}: {
  options: Options,
  logo: string,
  userGroupsMapping?: UserGroupsMapping,
  canChangeLanguage?: boolean,
  canChangeTheme?: boolean,
  providerLogout: boolean,
}): Node => {
  const auth = useAuth();
  const brand = useTheme();

  const { themeName, unSelectedThemes, setTheme } = useThemeName();
  const { language, setLanguage, unSelectedLanguages } = useLanguage();
  const intl = useIntl();

  const userGroups: string[] = getUserGroups(auth.userData, userGroupsMapping);
  const accessiblePaths = getAccessiblePathsFromOptions(options, userGroups);
  useLayoutEffect(() => {
    accessiblePaths.forEach((accessiblePath) => {
      prefetch(accessiblePath).catch(() => console.log(`Failed to preload ${accessiblePath}`));
    });
  }, [JSON.stringify(accessiblePaths)]);

  const tabs = translateOptionsToMenu(
    options,
    'main',
    (path, pathDescription) => ({
      link: <a href={path}>{pathDescription[language]}</a>,
    }),
    userGroups,
  );

  const rightActions = [
    {
      type: 'dropdown',
      text: auth.userData?.profile.name || '',
      icon: (
        <span style={{ color: brand.textTertiary }}>
          <i className="fas fa-user-cog"></i>
        </span>
      ),
      items: [
        ...translateOptionsToMenu(
          options,
          'subLogin',
          (path, pathDescription) => ({
            label: (
              // $FlowFixMe Dropdown item typing is currently a string but can also accepts a react node
              <Item
                icon={pathDescription.icon}
                isExternal={pathDescription.isExternal}
                label={pathDescription[language]}
              />
            ),
            onClick: () => {
              if (pathDescription.isExternal) {
                window.open(path, '_blank');
              } else {
                location.href = path;
              }
            },
          }),
          userGroups,
        ),
        {
          label: (
            <Item
              icon={'fas fa-sign-out-alt'}
              label={intl.formatMessage({ id: 'sign-out' })}
            />
          ),
          onClick: () => {
            logOut(auth.userManager, providerLogout);
          },
        },
      ],
    },
  ];

  if (canChangeLanguage) {
    rightActions.unshift({
      type: 'dropdown',
      text: language,
      items: unSelectedLanguages.map((lang) => ({
        label: lang,
        onClick: () => {
          setLanguage(lang);
        },
      })),
    });
  }

  if (canChangeTheme) {
    rightActions.unshift({
      type: 'dropdown',
      text: themeName,
      items: unSelectedThemes.map((theme) => ({
        label: theme,
        onClick: () => {
          setTheme(theme);
        },
      })),
    });
  }

  return (
    <CoreUINavbar
      logo={<Logo src={logo} alt="logo" />}
      rightActions={rightActions}
      tabs={tabs}
      role="navigation"
    />
  );
};
