# Copyright 2004-2014 Sabayon Linux
# Copyright 2015 Argent Linux
# Distributed under the terms of the GNU General Public License v2
# 

EAPI=4
inherit multilib

DESCRIPTION="Argent LibreOffice Artwork"
HOMEPAGE="http://www.argentlinux.io"
SRC_URI="mirror://argent/${CATEGORY}/${PN}/${PN}-${PVR}.tar.xz"
LICENSE="CCPL-Attribution-ShareAlike-3.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"

DEPEND="sys-apps/sed"
RDEPEND=""

S=${WORKDIR}/${PN}

src_install () {
	cd "${S}/images"
	sed -i "s:650:620:" sofficerc || die
	insinto /usr/$(get_libdir)/libreoffice/program
        doins *.png sofficerc
}

pkg_postinst () {
	ewarn "Please report bugs or glitches to"
	ewarn "bugs.argentlinux.io"
}
