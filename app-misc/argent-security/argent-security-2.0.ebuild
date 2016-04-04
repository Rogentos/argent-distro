# Copyright 2004-2014 Sabayon
# Copyright 2015 Argent
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Argent OS Security Package"
HOMEPAGE="http://argentlinux.io"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm x86"

IUSE=""
DEPEND=""
GCC_VER="4.8"
PYTHON_VER="2.7"
# Listing default packages for the current release
RDEPEND="!app-eselect/eselect-init
	!<sys-apps/sysvinit-1000
	!sys-apps/hal
	!sys-auth/consolekit
	sys-devel/base-gcc:${GCC_VER}
	sys-devel/gcc-config"

src_unpack () {
	# we need a working folder
        mkdir -p "${S}" || die
}

src_install () {
	# Bug 3459 - reduce the risk of fork bombs
	insinto /etc/security/limits.d
	doins "${FILESDIR}/00-argent-anti-fork-bomb.conf"
}
