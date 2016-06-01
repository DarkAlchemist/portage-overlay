# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-2

DESCRIPTION="silence-unless-failed script from Phusion Tools"
HOMEPAGE="https://github.com/phusion/phusion-server-tools"
EGIT_REPO_URI="https://github.com/phusion/phusion-server-tools.git"

SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	dodir /usr/local/
	into /usr/local/
	dobin silence-unless-failed
}
