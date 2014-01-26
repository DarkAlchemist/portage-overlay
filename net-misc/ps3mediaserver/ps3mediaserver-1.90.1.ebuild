# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ps3mediaserver/ps3mediaserver-1.90.1.ebuild,v 1.1 2014/01/01 15:15:51 floppym Exp $

EAPI="5"

inherit eutils user

DESCRIPTION="DLNA compliant UPNP server for streaming media to Playstation 3"
HOMEPAGE="http://code.google.com/p/ps3mediaserver"
SRC_URI="mirror://sourceforge/project/ps3mediaserver/pms-${PV}-generic-linux-unix.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+transcode tsmuxer"

DEPEND="app-arch/unzip"
RDEPEND=">=virtual/jre-1.6.0
	media-libs/libmediainfo
	media-libs/libzen
	tsmuxer? ( media-video/tsmuxer )
	transcode? ( media-video/mplayer[encode] )"

S=${WORKDIR}/pms-${PV}
PMS_HOME=/opt/${PN}
PMS_CONF=/etc/${PN}

PMS_USER="pms"
PMS_GROUP="pms"

src_prepare() {
	cat > ${PN} <<-EOF
	#!/bin/sh
	export PMS_HOME=${PMS_HOME}
	export PMS_PROFILE=${PMS_CONF}
	exec "\${PMS_HOME}/PMS.sh" "\$@"
	EOF
}

src_install() {
	dobin ${PN}

	exeinto ${PMS_HOME}
	doexe PMS.sh

	dodir /var/log/${PN}/${PMS_USER}

	# Fix for the newest version of PMS
	dodir ${PMS_CONF}
	
	insinto ${PMS_CONF}
	doins -r *.conf

	insinto ${PMS_HOME}
	doins -r pms.jar documentation plugins renderers *.xml
	
	use tsmuxer && dosym /opt/tsmuxer/bin/tsMuxeR ${PMS_HOME}/linux/tsMuxeR
	dodoc CHANGELOG.txt README.md

	newconfd "${FILESDIR}/${PN}.confd" ${PN}
	newinitd "${FILESDIR}/${PN}.initd" ${PN}
}

pkg_postinst() {
	enewgroup ${PMS_GROUP}
	enewuser ${PMS_USER} -1 -1 ${PMS_HOME}

	# Enforce user permissions on logging directory and main directory
	chown -R ${PMS_USER}:${PMS_GROUP} ${PMS_HOME}
	chown -R ${PMS_USER}:${PMS_GROUP} /var/log/${PN}

	if [[ -z ${REPLACING_VERSIONS} ]]; then
		ewarn "Don't forget to disable transcoding engines for software"
		ewarn "that you don't have installed (such as having the VLC"
		ewarn "transcoding engine enabled when you only have mencoder)."
	fi
}
