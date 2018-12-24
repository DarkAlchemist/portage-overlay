# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

inherit eutils user

DESCRIPTION="Universal Media Server. Multi-OS DLNA Compliant UPnP Media Server. A fork of PS3 Media Server"
HOMEPAGE="http://sourceforge.net/projects/unimediaserver"
SRC_URI="https://downloads.sourceforge.net/project/unimediaserver/Official%20Releases/Linux/UMS-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+ffmpeg +mencoder tsmuxer"

DEPEND="app-arch/unzip"
RDEPEND=">=virtual/jre-1.8.0-r1
	>=media-libs/libmediainfo-0.7.88
	media-libs/libzen
	mencoder? ( >media-video/mplayer-1.1.1-r1:=[a52,alsa,bidi,cdio,dts,dv,dvd,dvdnav,enca,encode,faac,faad,iconv,libass,mp3,theora,toolame,truetype,twolame,unicode,vorbis,x264,xvid] )
	tsmuxer? ( media-video/tsmuxer )
	ffmpeg? ( >=media-video/ffmpeg-2.8.7:=[bluray,bzip2,encode,fdk,fontconfig,gpl,hardcoded-tables,iconv,libass,mp3,threads,truetype,vorbis,x264,xvid,zlib] )
	>=media-libs/fdk-aac-0.1.3"

S=${WORKDIR}/ums-${PV}
UMS_HOME=/opt/${PN}
UMS_CONF=/etc/${PN}

UMS_USER="ums"
UMS_GROUP="ums"

pkg_setup(){
	enewgroup "${UMS_GROUP}"
	enewuser "${UMS_USER}" -1 -1 "${UMS_HOME}" "${UMS_GROUP}"
}

src_prepare() {
	cat > ${PN} <<-EOF
	#!/bin/sh

	# PMS Home is still used by the startup scripts in UMS currently
	export PMS_HOME=${UMS_HOME}
	
	# Set UMS_HOME for use later and if it's ever migrated
	export UMS_HOME=${UMS_HOME}

	# This overrides the default location for configurations
	export UMS_PROFILE=${UMS_CONF}

	# Start UMS
	exec "\${UMS_HOME}/UMS.sh" "\$@"
	EOF
}

src_install() {
	# Install script to start UMS
	dobin "${PN}"

	exeinto "${UMS_HOME}"
	doexe UMS.sh

	dodir "/var/log/UMS/${UMS_USER}"

	dodir "${UMS_CONF}"
	
	insinto "${UMS_CONF}"
	doins -r *.conf

	insinto "${UMS_HOME}"
	doins -r ums.jar documentation plugins renderers *.xml web

	dodoc CHANGELOG.txt README.txt

	dodir "${UMS_HOME}/bin"
	exeinto "${UMS_HOME}/bin"
	doexe linux/*

	newconfd "${FILESDIR}/${PN}.confd" "${PN}"
	newinitd "${FILESDIR}/${PN}.initd" "${PN}"
}

pkg_postinst() {
	# Enforce user permissions on logging directory and main directory
	chown -R "${UMS_USER}":"${UMS_GROUP}" "${UMS_HOME}"
	chown -R "${UMS_USER}":"${UMS_GROUP}" "/var/log/UMS"
	chown -R "${UMS_USER}":"${UMS_GROUP}" "${UMS_CONF}"
}
