# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit eutils depend.php

DESCRIPTION="PHP-based web interface to rsyslog and other network event data"
HOMEPAGE="http://adiscon.com"
SRC_URI="http://download.adiscon.com/${PN}/"${PN}"-"${PV}".tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~arm ~x86"
SLOT="0"
IUSE="mysql"

RDEPEND="app-admin/rsyslog
	mysql? ( >=virtual/mysql-4.1 )"

need_php_httpd
export MY_HTDOCSDIR="/usr/share/webapps/"${PN}""

src_configure() {
	cp -R "${S}"/contrib/* "${S}" || die
	mv configure.sh configure || die
	fperms +x configure || die
	econf || die
}

src_install() {
	insinto "${MY_HTDOCSDIR}"/

	doins configure || die
	doins contrib/secure.sh || die
	doins -r src/* || die

	doins config.php || die

	ewarn "Please run emerge --config $PN in order to"
	ewarn "configure and secure your files!"
}

pkg_config() {
	ewarn "Configuring files..."
	addwrite "${MY_HTDOCSDIR}"/

	chmod 755 "${MY_HTDOCSDIR}"/configure || die
	chmod 755 "${MY_HTDOCSDIR}"/secure.sh || die
	chmod 666 "${MY_HTDOCSDIR}"/config.php || die

	adddeny "${MY_HTDOCSDIR}"
	ewarn "Done."
}
