# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 pypy )

inherit distutils-r1

DESCRIPTION="Wrapper for Google Drive's API client for Python"
HOMEPAGE="https://pypi.python.org/pypi/PyDrive/"
SRC_URI="https://pypi.python.org/packages/bf/1b/d3980ef79ea9c184c7944bc82e6f698db962907d2187c8fa376f9f4617d9/PyDrive-${PV}.tar.gz#md5=87a8989e852c152161c14bbaac2b6c76 -> ${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
    >=dev-python/pyyaml-3.10[${PYTHON_USEDEP}]
    >=dev-python/google-api-python-client-1.3[${PYTHON_USEDEP}]
    "
DEPEND="${RDEPEND}"

S="${WORKDIR}/PyDrive-${PV}"
