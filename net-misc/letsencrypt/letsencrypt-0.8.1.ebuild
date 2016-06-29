# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3

DESCRIPTION="Official Let's Encrypt Certbot Client for generating valid SSL certificates"
HOMEPAGE="https://github.com/certbot/certbot.git"
EGIT_REPO_URI="https://github.com/certbot/certbot.git"
EGIT_COMMIT="v0.8.1"

SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-lang/python:2.7
    dev-python/virtualenv
    dev-util/dialog
    app-admin/augeas
    dev-libs/openssl
    dev-libs/libffi
    app-misc/ca-certificates
    virtual/pkgconfig"

RDEPEND="${DEPEND}"

src_install() {

	dodir /etc/${PN}
	
	dodir /opt/${PN}
	insinto /opt/${PN}
	
	doins -r *

	exeinto /opt/${PN}
	doexe certbot-auto
	doexe letsencrypt-auto
	
	# Custom support for CLI files
	dodir /etc/${PN}/cli-conf
    
	# Wrapper/utility scripts to make it slightly easier
	# These also make sure that /opt/${PN}/.local is used for Python VirtualEnv
	into "/usr"
	dosbin ${FILESDIR}/*

}

pkg_postinst(){
	ewarn "Due to the way Let's Encrypt works on Gentoo, please only call it via the wrapper scripts in /usr/sbin/ prefixed with certbot/letsencrypt"
	ewarn "As part of the bootstrap process, Gentoo support is experimental. Please run 'sudo letsencrypt-auto-noupdate --debug' to install the Python dependencies"
	ewarn "These will install into '/opt/${PN}/.local' under a Python VirtualEnv"
	ewarn "Gentoo dependencies are taken care of as part of this ebuild"
}
