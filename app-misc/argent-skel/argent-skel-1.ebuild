# Copyright 2004-2014 Sabayon Linux
# Copyright 2015 Argent Linux
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
EGIT_COMMIT="${PVR}"
EGIT_REPO_URI="git://github.com/Argent/skel.git"

inherit eutils git-2 fdo-mime

DESCRIPTION="Argent Linux skel tree"
HOMEPAGE="http://www.argentlinux.org"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""
RDEPEND="!<=app-misc/argentlinux-skel-3.5-r6"

src_install () {
	dodir /etc/xdg/menus
	cp "${S}"/* "${D}"/etc/ -Ra

	# Argent Menu
	dodir /usr/share/desktop-directories
	cp "${FILESDIR}"/1.0/xdg/*.directory "${D}"/usr/share/desktop-directories/
	dodir /usr/share/argent
	cp -a "${FILESDIR}"/1.0/* "${D}"/usr/share/argent/
	doicon "${FILESDIR}"/1.0/img/argent-weblink.png

	chown root:root "${D}"/etc/skel -R
}

pkg_postinst () {
	if [ -x "/usr/bin/xdg-desktop-menu" ]; then
		# Manual install otherwise it wont be set up correctly
		xdg-desktop-menu install \
			/usr/share/argent/xdg/argent-argent.directory \
			/usr/share/argent/xdg/*.desktop
	fi

	fdo-mime_desktop_database_update
}


pkg_prerm() {
	if [ -x "/usr/bin/xdg-desktop-menu" ]; then
		xdg-desktop-menu uninstall /usr/share/argent/xdg/argent-argent.directory /usr/share/argent/xdg/*.desktop
	fi
}
