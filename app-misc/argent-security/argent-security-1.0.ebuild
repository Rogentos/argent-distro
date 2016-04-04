# Copyright 2004-2014 Sabayon
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="Argent system release virtual package"
HOMEPAGE="http://www.argentlinux.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"

IUSE=""
DEPEND=""
# Listing default packages for the current release
RDEPEND="app-eselect/eselect-python
	dev-lang/python:2.7
	sys-devel/base-gcc:4.6
	sys-devel/gcc-config"

src_unpack () {
	echo "Argent Linux ${ARCH} ${PV}" > "${T}/argent-release"
}

src_install () {
	insinto /etc
	doins "${T}"/argent-release
	dosym /etc/argent-release /etc/system-release
	# Bug 3459 - reduce the risk of fork bombs
	insinto /etc/security/limits.d
	doins "${FILESDIR}/00-argent-anti-fork-bomb.conf"
}

pkg_postinst() {
	# Setup Python 2.7
	eselect python update --ignore 3.0 --ignore 3.1 --ignore 3.2 --ignore 3.3 --ignore 3.4
}
