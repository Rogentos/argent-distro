# Copyright 2004-2014 Sabayon Linux
# Copyright 2014 Argent Linux
# Distributed under the terms of the GNU General Public License v2

inherit eutils

DESCRIPTION="Argent Linux GRUB utilities"
HOMEPAGE="http://www.argentlinux.org/"
SRC_URI=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

src_install () {
	exeinto /usr/sbin
	doexe "${FILESDIR}/${PN}"
}
