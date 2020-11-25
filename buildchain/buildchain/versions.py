# coding: utf-8


"""Authoritative listing of image and package versions used in the project.

This module MUST be kept valid in a standalone context, since it is intended
for use in tests and documentation as well.
"""
import operator

from collections import namedtuple
from pathlib import Path
from typing import cast, Dict, Optional, Tuple


Image = namedtuple('Image', ('name', 'version', 'digest'))

# Project-wide versions {{{

CALICO_VERSION     : str = '3.17.0'
K8S_VERSION        : str = '1.18.12'
SALT_VERSION       : str = '3002.2'
CONTAINERD_VERSION : str = '1.4.1'
CONTAINERD_RELEASE : str = '1.el7'

def load_version_information() -> None:
    """Load version information from `VERSION`."""
    to_update = {
        'VERSION_MAJOR', 'VERSION_MINOR', 'VERSION_PATCH', 'VERSION_SUFFIX'
    }
    with VERSION_FILE.open('r', encoding='utf-8') as fp:
        for line in fp:
            name, _, value = line.strip().partition('=')
            # Don't overwrite random variables by trusting an external file.
            var = name.strip()
            if var in to_update:
                globals()[var] = value.strip()


VERSION_FILE = (Path(__file__)/'../../../VERSION').resolve()

# Metalk8s version.
# (Those declarations are not mandatory, but they help pylint and mypy).
VERSION_MAJOR  : str
VERSION_MINOR  : str
VERSION_PATCH  : str
VERSION_SUFFIX : str

load_version_information()

SHORT_VERSION : str = '{}.{}'.format(VERSION_MAJOR, VERSION_MINOR)
VERSION : str = '{}.{}{}'.format(SHORT_VERSION, VERSION_PATCH, VERSION_SUFFIX)


# }}}
# Container images {{{

CENTOS_BASE_IMAGE : str = 'docker.io/centos'
CENTOS_BASE_IMAGE_SHA256 : str = \
    '6ae4cddb2b37f889afd576a17a5286b311dcbf10a904409670827f6f9b50065e'

GRAFANA_IMAGE_VERSION : str = '6.7.4'
NGINX_IMAGE_VERSION   : str = '1.15.8'
NODEJS_IMAGE_VERSION  : str = '10.16.0'

# Current build IDs, to be augmented whenever we rebuild the corresponding
# image, e.g. because the `Dockerfile` is changed, or one of the dependencies
# installed in the image needs to be updated.
# This should be reset to 1 when the service exposed by the container changes
# version.
SALT_MASTER_BUILD_ID = 1


def _version_prefix(version: str, prefix: str = 'v') -> str:
    return "{}{}".format(prefix, version)


# Digests are quite a mouthful, so:
# pylint:disable=line-too-long
CONTAINER_IMAGES : Tuple[Image, ...] = (
    # Remote images
    Image(
        name='alertmanager',
        version='v0.20.0',
        digest='sha256:7e4e9f7a0954b45736d149c40e9620a6664036bb05f0dce447bef5042b139f5d',
    ),
    Image(
        name='calico-node',
        version=_version_prefix(CALICO_VERSION),
        digest='sha256:92227666988edccd1222d463173489fd656c5a37b8dedab0dadfbc22a471893a',
    ),
    Image(
        name='calico-kube-controllers',
        version=_version_prefix(CALICO_VERSION),
        digest='sha256:78a6e7648e22b2c87fcc06db610d753e49c6f9b3cf622ab23fdc3a63c1563fc8',
    ),
    Image(
        name='configmap-reload',
        version='v0.0.1',
        digest='sha256:e2fd60ff0ae4500a75b80ebaa30e0e7deba9ad107833e8ca53f0047c42c5a057',
    ),
    Image(
        name='coredns',
        version='1.6.7',
        digest='sha256:2c8d61c46f484d881db43b34d13ca47a269336e576c81cf007ca740fa9ec0800',
    ),
    Image(
        name='dex',
        version='v2.23.0',
        digest='sha256:b0bbc14a503a97587b365113a2f171a04ee7a6fd6f84c52e9384400533c9276c',
    ),
    Image(
        name='etcd',
        version='3.4.3-0',
        digest='sha256:4afb99b4690b418ffc2ceb67e1a17376457e441c1f09ab55447f0aaf992fa646',
    ),
    Image(
        name='k8s-sidecar',
        version='0.1.20',
        digest='sha256:af151f677a63cdfcdfc18a4e3043520ec506d5e116692e5190f6f765dca42a52',
    ),
    Image(
        name='kube-apiserver',
        version=_version_prefix(K8S_VERSION),
        digest='sha256:939637424b77e049556915a038eb09a85234f372eac2184233ba5d336d20cb3e',
    ),
    Image(
        name='kube-controller-manager',
        version=_version_prefix(K8S_VERSION),
        digest='sha256:842498cf3757fcf6aa12b480590126ced656f4cf6a250573101a864f2f60ce30',
    ),
    Image(
        name='kube-proxy',
        version=_version_prefix(K8S_VERSION),
        digest='sha256:b639ad7fcbf49b855153861e55b8c6246b88ffff0b7c7d0e3610c9711add1460',
    ),
    Image(
        name='kube-scheduler',
        version=_version_prefix(K8S_VERSION),
        digest='sha256:f7eb0ee797aecce73e85b0d6aafb6c356ffe232bca2779cf0195423b918d883b',
    ),
    Image(
        name='kube-state-metrics',
        version='v1.9.5',
        digest='sha256:9d29333ad1cc8e14b26e40daea3739cec21b765f6077c6764546779deec3f54b',
    ),
    Image(
        name='nginx',
        version=NGINX_IMAGE_VERSION,
        digest='sha256:f09fe80eb0e75e97b04b9dfb065ac3fda37a8fac0161f42fca1e6fe4d0977c80',
    ),
    Image(
        name='nginx-ingress-controller',
        version='0.30.0',
        digest='sha256:b312c91d0de688a21075078982b5e3a48b13b46eda4df743317d3059fc3ca0d9',
    ),
    Image(
        name='nginx-ingress-defaultbackend-amd64',
        version='1.5',
        digest='sha256:4dc5e07c8ca4e23bddb3153737d7b8c556e5fb2f29c4558b7cd6e6df99c512c7',
    ),
    Image(
        name='node-exporter',
        version='v0.18.1',
        digest='sha256:a2f29256e53cc3e0b64d7a472512600b2e9410347d53cdc85b49f659c17e02ee',
    ),
    Image(
        name='pause',
        version='3.1',
        digest='sha256:da86e6ba6ca197bf6bc5e9d900febd906b133eaa4750e6bed647b0fbe50ed43e',
    ),
    Image(
        name='prometheus',
        version='v2.16.0',
        digest='sha256:e4ca62c0d62f3e886e684806dfe9d4e0cda60d54986898173c1083856cfda0f4',
    ),
    Image(
        name='k8s-prometheus-adapter-amd64',
        version='v0.6.0',
        digest='sha256:b63dc612e3cb73f79d2401a4516f794f9f0a83002600ca72e675e41baecff437',
    ),
    Image(
        name='prometheus-config-reloader',
        version='v0.38.1',
        digest='sha256:d1cce64093d4a850d28726ec3e48403124808f76567b5bd7b26e4416300996a7',
    ),
    Image(
        name='prometheus-operator',
        version='v0.38.1',
        digest='sha256:62b8cf466e9b238a9fcf0bcba74562c8833e7451042321e323a46de3f1dbe1bc',
    ),
    # Local images
    Image(
        name='grafana',
        version=GRAFANA_IMAGE_VERSION,
        digest=None,
    ),
    Image(
        name='metalk8s-ui',
        version=VERSION,
        digest=None,
    ),
    Image(
        name='metalk8s-utils',
        version=VERSION,
        digest=None,
    ),
    Image(
        name='salt-master',
        version='{version}-{build_id}'.format(
            version=SALT_VERSION, build_id=SALT_MASTER_BUILD_ID
        ),
        digest=None,
    ),
    Image(
        name='storage-operator',
        version='latest',
        digest=None,
    ),
    Image(
        name='loki',
        version='2.0.0',
        digest='sha256:77e138f81a8e253f1d0ea5d2dc329a02212ecab3247c87f85f1f2182a0160ccd',
    ),
    Image(
        name='fluent-bit-plugin-loki',
        version='1.6.0-amd64',
        digest='sha256:cb1cd95d0fcf76b626623684f0c8b204a9f773443650c7b3d243b96c29ff7020',
    ),
)

CONTAINER_IMAGES_MAP = {image.name: image for image in CONTAINER_IMAGES}

# }}}

# Packages {{{

class PackageVersion:
    """A package's authoritative version data.

    This class contains version information for a named package, and
    provides helper methods for formatting version/release data as well
    as version-enriched package name, for all supported OS families.
    """

    def __init__(
        self,
        name: str,
        version: Optional[str] = None,
        release: Optional[str] = None,
        override: Optional[str] = None
    ):
        """Initializes a package version.

        Arguments:
            name: the name of the package
            version: the version of the package
            release: the release of the package
        """
        self._name     = name
        self._version  = version
        self._release  = release
        self._override = override

    name = property(operator.attrgetter('_name'))
    version = property(operator.attrgetter('_version'))
    release = property(operator.attrgetter('_release'))
    override = property(operator.attrgetter('_override'))

    @property
    def full_version(self) -> Optional[str]:
        """The full package version string."""
        full_version = None
        if self.version:
            full_version = self.version
            if self.release:
                full_version = '{}-{}'.format(self.version, self.release)
        return full_version

    @property
    def rpm_full_name(self) -> str:
        """The package's full name in RPM conventions."""
        if self.full_version:
            return '{}-{}'.format(self.name, self.full_version)
        return cast(str, self.name)

    @property
    def deb_full_name(self) -> str:
        """The package's full name in DEB conventions."""
        if self.full_version:
            return '{}={}'.format(self.name, self.full_version)
        return cast(str, self.name)


# The authoritative list of packages required.
#
# Common packages are packages for which we need not care about OS-specific
# divergences.
#
# In this case, either:
#   * the _latest_ version is good enough, and will be the one
#     selected by the package managers (so far: apt and yum).
#   * we have strict version requirements that span OS families, and the
#     version schemes _and_ package names do not diverge
#
# Strict version requirements are notably:
#   * kubelet and kubectl which _make_ the K8s version of the cluster
#   * salt-minion which _makes_ the Salt version of the cluster
#
# These common packages may be overridden by OS-specific packages if package
# names or version conventions diverge.
#
# Packages that we build ourselves require a version and release as part of
# their build process.
PACKAGES: Dict[str, Tuple[PackageVersion, ...]] = {
    'common': (
        # Pinned packages
        PackageVersion(name='kubectl', version=K8S_VERSION),
        PackageVersion(name='kubelet', version=K8S_VERSION),
        # Latest packages
        PackageVersion(name='coreutils'),
        PackageVersion(name='cri-tools'),
        PackageVersion(name='e2fsprogs'),
        PackageVersion(name='ebtables'),
        PackageVersion(name='ethtool'),
        PackageVersion(name='genisoimage'),
        PackageVersion(name='iproute'),
        PackageVersion(name='iptables'),
        PackageVersion(name='kubernetes-cni'),
        PackageVersion(name='m2crypto'),
        PackageVersion(name='runc'),
        PackageVersion(name='salt-minion', version=SALT_VERSION),
        PackageVersion(name='socat'),
        PackageVersion(name='sos'),  # TODO download built package dependencies
        PackageVersion(name='util-linux'),
        PackageVersion(name='xfsprogs'),
    ),
    'redhat': (
        PackageVersion(
            name='calico-cni-plugin',
            version=CALICO_VERSION,
            release='1.el7'
        ),
        PackageVersion(
            name='containerd',
            version=CONTAINERD_VERSION,
            release=CONTAINERD_RELEASE,
        ),
        PackageVersion(name='container-selinux'),  # TODO #1710
        PackageVersion(name='httpd-tools'),
        PackageVersion(
            name='metalk8s-sosreport',
            version=SHORT_VERSION,
            release='1.el7'
        ),
        PackageVersion(name='python36-rpm'),
        PackageVersion(name='yum-plugin-versionlock'),
        PackageVersion(name='yum-utils'),
    ),
    'debian': (
        PackageVersion(
            name='calico-cni-plugin',
            version=CALICO_VERSION,
            release='1'
        ),
        PackageVersion(name='iproute2', override='iproute'),
        PackageVersion(
            name='metalk8s-sosreport',
            version=SHORT_VERSION,
            release='1'
        ),
        PackageVersion(name='python-m2crypto', override='m2crypto'),
        PackageVersion(name='sosreport', override='sos'),
    ),
}


def _list_pkgs_for_os_family(os_family: str) -> Tuple[PackageVersion, ...]:
    """List downloaded packages for a given OS family.

    Arguments:
        os_family: OS_family for which to list packages
    """
    common_pkgs = PACKAGES['common']
    os_family_pkgs = PACKAGES.get(os_family)

    if os_family_pkgs is None:
        raise Exception('No packages for OS family: {}'.format(os_family))

    os_override_names = [
        pkg.override for pkg in os_family_pkgs
        if pkg.override is not None
    ]

    overridden = filter(
        lambda item: item.name not in os_override_names,
        common_pkgs
    )

    return tuple(overridden) + os_family_pkgs


RPM_PACKAGES = _list_pkgs_for_os_family('redhat')

RPM_PACKAGES_MAP = {pkg.name: pkg for pkg in RPM_PACKAGES}

DEB_PACKAGES = _list_pkgs_for_os_family('debian')

DEB_PACKAGES_MAP = {pkg.name: pkg for pkg in DEB_PACKAGES}

# }}}
