# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

use git-2

DESCRIPTION="Standard library of functions for bash"
HOMEPAGE="https://github.com/srcshelton/stdlib.sh"
EGIT_REPO_URI="https://github.com/srcshelton/stdlib.sh.git"

SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	dodir /usr/local/
	into /usr/local/
	dolib stdlib.sh
}
