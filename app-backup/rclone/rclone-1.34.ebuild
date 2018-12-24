# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

inherit eutils

DESCRIPTION="Mirror directories to cloud storage"
HOMEPAGE="http://www.rclone.org"
SRC_URI="http://downloads.rclone.org/${PN}-v${PV}-linux-amd64.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-v${PV}-linux-amd64"

src_install() {
	dobin ${PN}
	doman ${PN}.1
}
