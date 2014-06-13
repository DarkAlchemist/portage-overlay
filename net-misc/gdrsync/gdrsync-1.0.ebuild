# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit git-2

EGIT_REPO_URI="https://github.com/quisar/gdrsync.py.git"
EGIT_PROJECT="with-download-2"
EGIT_BRANCH="with-download-2"
EGIT_COMMIT="with-download-2"

DESCRIPTION="Python script that emulates rsync between a host and Google Drive"
HOMEPAGE="https://github.com/quisar/gdrsync.py"
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 amd64"
IUSE=""

DEPEND=""
RDEPEND="dev-python/google-api-python-client"

APP_HOME="/opt/${PN}"

src_prepare() {
	cat > "${PN}" <<-EOF
	#!/bin/sh
	exec "${APP_HOME}/gdrsync.py" "\$@"	
	EOF
}

src_install() {
	
	# Install run script into /usr/bin
	dobin "${PN}"

	# Install application components
	dodir "${APP_HOME}"
	exeinto "${APP_HOME}"
	doexe *.py

	dodir "${APP_HOME}/doc"
	insinto "${APP_HOME}/doc"
	doins *.txt *.md
}
