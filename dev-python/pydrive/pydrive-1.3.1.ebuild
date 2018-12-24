# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 pypy )

inherit distutils-r1

DESCRIPTION="Wrapper for Google Drive's API client for Python"
HOMEPAGE="https://pypi.python.org/pypi/PyDrive/"
SRC_URI="https://github.com/gsuitedevs/PyDrive/archive/1.3.1.tar.gz"

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
