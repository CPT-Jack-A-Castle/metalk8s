// TO BE FIXED: Mock import { store } from '../index' in 'config.js'
// Otherwise we have some issues to initialize reducers for testing
jest.mock('../index.js', () => {
  return {
    store: 'store',
  };
});

import { call, put } from 'redux-saga/effects';
import history from '../history';
import {
  SALT_AUTHENTICATION_SUCCESS,
  authenticateSaltApi,
} from './login';
import { CONNECT_SALT_API } from './app/salt';
import * as ApiSalt from '../services/salt/api';
import { LOGOUT } from './config';
it('Salt authentication success', () => {
  ApiSalt.initialize('url');
  const gen = authenticateSaltApi();
  expect(gen.next().value.type).toEqual('SELECT');
  const api = { url_salt: 'url_salt' };
  expect(gen.next(api).value.type).toEqual('SELECT');
  const user = {
    name: 'carlito',
  };
  expect(gen.next(user).value).toEqual(call(ApiSalt.authenticate, user));

  const result = {
    return: [{ token: 'abc' }],
  };

  expect(gen.next(result).value).toEqual(
    call(ApiSalt.getClient().setHeaders, {
      'X-Auth-Token': 'abc',
    }),
  );
  expect(gen.next(result).value).toEqual(
    put({
      type: SALT_AUTHENTICATION_SUCCESS,
      payload: result,
    }),
  );
  expect(gen.next(result).value).toEqual(
    put({
      type: CONNECT_SALT_API,
      payload: {
        url: 'url_salt',
        token: 'abc',
      },
    }),
  );
  expect(gen.next().done).toEqual(true);
});

it('Salt authentication failed', () => {
  ApiSalt.initialize('url');
  const gen = authenticateSaltApi();
  expect(gen.next().value.type).toEqual('SELECT');
  const api = { url_salt: 'url_salt' };
  expect(gen.next(api).value.type).toEqual('SELECT');
  const user = {
    name: 'carlito',
  };
  expect(gen.next(user).value).toEqual(call(ApiSalt.authenticate, user));

  const result = {
    error: 'error',
  };

  expect(gen.next(result).value).toEqual(put({ type: LOGOUT }));
  expect(gen.next().done).toEqual(true);
});
