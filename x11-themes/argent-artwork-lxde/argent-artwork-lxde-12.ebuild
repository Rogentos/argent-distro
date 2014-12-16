# Copyright 2004-2014 Sabayon Promotion
# Copyright 2004-2014 Sabayon Promotion
# Distributed under the terms of the GNU General Public License v2
#

EAPI=3

inherit base

DESCRIPTION="Argent LXDE Artwork"
HOMEPAGE="http://www.argent.ro/"
SRC_URI="mirror://argent/${CATEGORY}/${PN}/${PN}-${PVR}.tar.xz"
LICENSE="CCPL-Attribution-ShareAlike-3.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""
RDEPEND="x11-themes/argent-artwork-core"

S="${WORKDIR}/${PN}"

src_install () {
	cd "${S}"/lxdm
	dodir /usr/share/lxdm/themes/Argent
	insinto /usr/share/lxdm/themes/Argent
	doins Argent/*

	dosym /usr/share/backgrounds/kgdm.png \
		/usr/share/lxdm/themes/Argent/kgdm.png
}
