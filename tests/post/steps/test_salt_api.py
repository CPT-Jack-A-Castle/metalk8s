import ast
import base64
import json

import requests

import pytest
from pytest_bdd import parsers, scenario, then, when


def _negation(value):
    """Parse an optional negation after a verb (in a Gherkin feature spec)."""
    if value == "":
        return False
    elif value in [" not", "not"]:
        return True
    else:
        raise ValueError(
            "Cannot parse '{}' as an optional negation".format(value)
        )

# Scenario {{{


@scenario('../features/salt_api.feature', 'Login to SaltAPI using Basic auth')
def test_login_basic_auth_to_salt_api(host):
    pass


@scenario('../features/salt_api.feature',
          'Login to SaltAPI using an admin ServiceAccount')
@scenario('../features/salt_api.feature',
          'Login to SaltAPI using a ServiceAccount')
def test_login_bearer_auth_to_salt_api(host):
    pass


@pytest.fixture(scope='function')
def context():
    return {}


# }}}
# When {{{


@when(parsers.parse(
    "we login to SaltAPI as '{username}' using password '{password}'"))
def login_salt_api_basic(host, username, password, version, context):
    address = _get_salt_api_address(host, version)
    token = base64.encodebytes(
        '{}:{}'.format(username, password).encode('utf-8')
    ).rstrip()
    context['salt-api'] = _salt_api_login(
        address, username=username, password=token
    )


@when("we login to SaltAPI with an admin ServiceAccount")
def login_salt_api_admin_sa(host, k8s_client, admin_sa, version, context):
    sa_name, sa_namespace = admin_sa
    address = _get_salt_api_address(host, version)

    context['salt-api'] = _login_salt_api_sa(
        address, k8s_client,
        sa_name, sa_namespace
    )


@when(parsers.parse(
    "we login to SaltAPI with the ServiceAccount '{account_name}'"))
def login_salt_api_system_sa(host, k8s_client, account_name, version, context):
    address = _get_salt_api_address(host, version)

    context['salt-api'] = _login_salt_api_sa(
        address, k8s_client,
        account_name, 'kube-system'
    )


# }}}
# Then {{{


@then(parsers.cfparse(
    'we can{negated:Negation?} ping all minions',
    extra_types={'Negation': _negation}
))
def ping_all_minions(host, context, negated):
    result = _salt_call(context, 'test.ping', tgt='*')

    if negated:
        assert result.status_code == 401
        assert 'No permission' in result.text
    else:
        result_data = result.json()
        assert result_data['return'][0] != []


@then(parsers.cfparse(
    "we can{negated:Negation?} run state '{module}' on '{targets}'",
    extra_types={'Negation': _negation}
))
def run_state_on_targets(host, context, negated, module, targets):
    result = _salt_call(context, 'state.sls', tgt=targets,
                        kwarg={'mods': module})

    if negated:
        assert result.status_code == 401
        assert 'No permission' in result.text
    else:
        assert result.status_code == 200


@then('authentication fails')
def authentication_fails(host, context):
    assert context['salt-api']['login-status-code'] == 401

@then(parsers.parse("we can invoke '{modules}' on '{targets}'"))
def invoke_module_on_target(host, context, modules, targets):
    assert {targets: ast.literal_eval(modules)} in context['salt-api']['perms']

@then(parsers.parse("we have '{perms}' perms"))
def have_perms(host, context, perms):
    assert perms in context['salt-api']['perms']


# }}}
# Helpers {{{


def _login_salt_api_sa(address, k8s_client, sa_name, sa_namespace):
    service_account = k8s_client.read_namespaced_service_account(
        name=sa_name, namespace=sa_namespace
    )
    secret = k8s_client.read_namespaced_secret(
        name=service_account.secrets[0].name, namespace=sa_namespace
    )
    token = base64.decodebytes(secret.data['token'].encode('utf-8'))
    return _salt_api_login(
        address, username=sa_name, token=token
    )


def _get_salt_api_address(host, version):
    SALT_API_PORT = 4507
    cmd_cidr = ' '.join([
        'salt-call', 'pillar.get',
        'networks:control_plane',
        'saltenv=metalk8s-{version}'.format(version=version),
        '--out', 'json',
    ])
    with host.sudo():
        cidr_output = host.check_output(cmd_cidr)
    cidr = json.loads(cidr_output)['local']

    cmd_ip = ' '.join([
        'salt-call', '--local',
        'network.ip_addrs',
        'cidr="{cidr}"'.format(cidr=cidr),
        '--out', 'json',
    ])
    with host.sudo():
        cmd_output = host.check_output(cmd_ip)
    ip = json.loads(cmd_output)['local'][0]
    return '{}:{}'.format(ip, SALT_API_PORT)


def _salt_api_login(address, username=None, password=None, token=None):
    data = {
        'eauth': 'kubernetes_rbac'
    }

    if username:
        data['username'] = username
    if password:
        data['password'] = password
    if token:
        data['token'] = token

    response = requests.post(
        'https://{}/login'.format(address),
        data=data,
        verify=False,
    )
    result = {
        'url': 'https://{}'.format(address),
        'token': None,
        'perms': [],
        'login-status-code': response.status_code,
    }
    if response.status_code == 200:
        json_data = response.json()
        result['token'] = json_data['return'][0]['token']
        result['perms'] = json_data['return'][0]['perms']
    return result


def _salt_call(context, fun, tgt='*', arg=None, kwarg=None):
    action = {
        'client': 'local',
        'tgt': tgt,
        'fun': fun,
    }
    if arg is not None:
        action['arg'] = arg
    if kwarg is not None:
        action['kwarg'] = kwarg

    return requests.post(
        context['salt-api']['url'],
        json=[action],
        headers={
            'X-Auth-Token': context['salt-api']['token'],
        },
        verify=False,
    )


# }}}
