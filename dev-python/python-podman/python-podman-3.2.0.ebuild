# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..9} )
inherit distutils-r1

MY_P=podman-py-${PV}
DESCRIPTION="A library to interact with a Podman server"
HOMEPAGE="
	https://github.com/containers/podman-py/
	https://pypi.org/project/podman/"
SRC_URI="
	https://github.com/containers/podman-py/archive/v${PV}.tar.gz
		-> ${MY_P}.tar.gz"
S=${WORKDIR}/${MY_P}

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/pyxdg[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/toml[${PYTHON_USEDEP}]
	dev-python/urllib3[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

python_test() {
	local deselect=(
		# integration tests require a workable podman server,
		# and it doesn't seem to work in ebuild env
		podman/tests/integration

		# TODO
		podman/tests/unit/test_volumesmanager.py::VolumesManagerTestCase::test_get_404
	)

	epytest ${deselect[@]/#/--deselect }
}
