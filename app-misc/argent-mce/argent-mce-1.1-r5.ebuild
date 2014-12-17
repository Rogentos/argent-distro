# Copyright 2004-2014 Sabayon
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils systemd

DESCRIPTION="Argent Linux Media Center Infrastructure"
HOMEPAGE="http://www.argentlinux.org/"
SRC_URI=""

RESTRICT="nomirror"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm x86"
IUSE=""

RDEPEND="media-tv/xbmc app-misc/argent-live"
DEPEND=""

S="${WORKDIR}"

src_install () {
	local dir="${FILESDIR}/${PV}"

	doinitd "${dir}/init.d/argent-mce"
	systemd_dounit "${dir}"/systemd/*

	dodir /usr/bin
	exeinto /usr/bin
	doexe "${dir}"/bin/*

	dodir /usr/libexec
	exeinto /usr/libexec
	doexe "${dir}"/libexec/*

	dodir /usr/share/xsessions
	insinto /usr/share/xsessions
	doins "${dir}"/xsession/*.desktop
}

pkg_postinst() {
	# create new user argentmce
	local mygroups="users"
	local gr="lp wheel uucp audio cdrom scanner video "
	gr+="cdrw usb plugdev polkituser"

	for mygroup in ${gr}; do
		if [[ -n $(egetent group "${mygroup}") ]]; then
			mygroups+=",${mygroup}"
		fi
	done
	enewuser argentmce -1 /bin/sh /var/argentmce "${mygroups}"
}
