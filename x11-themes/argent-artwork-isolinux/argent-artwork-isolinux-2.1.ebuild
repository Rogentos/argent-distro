# Copyright 2004-2014 Sabayon
# Copyright 2015 Argent
# Distributed under the terms of the GNU General Public License v2
#

EAPI=4

inherit base

DESCRIPTION="Argent Isolinux Live Images Background"
HOMEPAGE="http://www.argentlinux.io/"
SRC_URI="mirror://argent/${CATEGORY}/${PN}/${PN}-${PVR}.tar.xz
	bpr.bluepink.ro/~rogentos/argent/${CATEGORY}/${PN}/${PN}-${PVR}.tar.xz"

LICENSE="CCPL-Attribution-ShareAlike-3.0"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE=""
RDEPEND=""

S="${WORKDIR}/${PN}"

src_install () {
	cd "${S}/images"
	dodir /usr/share/backgrounds/isolinux
	insinto /usr/share/backgrounds/isolinux
	doins back.jpg
}
