# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit pam

DESCRIPTION="Google Authenticator PAM module for 2-factor Authentication"
HOMEPAGE="https://code.google.com/p/google-authenticator"
SRC_URI="https://google-authenticator.googlecode.com/files/libpam-google-authenticator-1.0-source.tar.bz2"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-libs/pam"
RDEPEND="${DEPEND}"

S="${WORKDIR}/libpam-google-authenticator-1.0"

src_install(){
	insinto $(getpam_mod_dir)
	doins pam_google_authenticator.so
	dobin google-authenticator

	dodoc README
}
