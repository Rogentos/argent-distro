# Copyright 2004-2014 Sabayon
# Copyright 2015 Argent Linux
# Distributed under the terms of the GNU General Public License v2
#

EAPI=5
inherit eutils mount-boot argent-artwork

DESCRIPTION="Official Argent Linux Core Artwork"
HOMEPAGE="http://www.argentlinux.io/"
SRC_URI="http://bpr.bluepink.ro/~rogentos/argent/${CATEGORY}/${PN}/${PN}-${PVR}.tar.xz
	mirror://argent/${CATEGORY}/${PN}/${PN}-${PVR}.tar.xz"

LICENSE="CCPL-Attribution-ShareAlike-3.0"
SLOT="0"
KEYWORDS="~arm x86 amd64"
IUSE=""
RDEPEND="
	sys-apps/findutils"

S="${WORKDIR}/${PN}"

src_install() {
	# Fbsplash theme
	#cd "${S}"/fbsplash || die
	#dodir /etc/splash/argent
	#cp -r "${S}"/fbsplash/argent/* "${D}"/etc/splash/argent

	# Cursors
	cd "${S}"/mouse/entis/cursors || die
	dodir /usr/share/cursors/xorg-x11/entis/cursors
	insinto /usr/share/cursors/xorg-x11/entis/cursors
	doins -r ./

	# Wallpaper
	cd "${S}"/background || die
	insinto /usr/share/backgrounds
	doins *.png *.jpg
	newins argentlinux.png argentlinux-nvidia.png

	# Plymouth
	cd "${S}/plymouth" || die
	insinto /usr/share/plymouth
	doins bizcom.png
	insinto /usr/share/plymouth/themes
	doins -r argent
}

pkg_postinst() {
	# mount boot first
	mount-boot_mount_boot_partition

	einfo "Please report bugs or glitches to"
	einfo "http://bugs.argentlinux.io"
}
