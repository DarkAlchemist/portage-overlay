# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

inherit eutils

DESCRIPTION="Java tool for organising and renaming anime, movies and tv shows"
HOMEPAGE="http://www.filebot.net"
SRC_URI="mirror://sourceforge/project/filebot/filebot/FileBot_${PV}/FileBot_${PV}.jar"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/jre
	media-libs/libmediainfo"
RDEPEND="${DEPEND}"

FILEBOT_HOME="/opt/FileBot"

src_unpack() {
:
}

src_prepare() {
	# Generate launch script wrapper for filebot
	cat > ${PN} <<-EOF
	#!/bin/sh
	java -jar ${FILEBOT_HOME}/FileBot_${PV}.jar "\$@"
	EOF
}

src_install() {
	dobin ${PN}

	insinto ${FILEBOT_HOME}
	doins "${DISTDIR}"/FileBot_${PV}.jar
}
