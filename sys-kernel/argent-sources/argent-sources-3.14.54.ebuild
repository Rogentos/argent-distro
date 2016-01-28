# Copyright 2004-2014 Sabayon and ArgOS Linux
# Distributed under the terms of the GNU General Public License v2

EAPI=5

K_ARGKERNEL_NAME="argent"
K_ARGKERNEL_URI_CONFIG="yes"
K_ARGKERNEL_SELF_TARBALL_NAME="argent"
K_ONLY_SOURCES="1"
K_ARGKERNEL_FORCE_SUBLEVEL="0"
K_KERNEL_NEW_VERSIONING="1"

inherit argent-kernel

KEYWORDS="amd64 x86"
DESCRIPTION="Official Argent Linux Standard kernel sources"
RESTRICT="mirror"
IUSE="sources_standalone"

DEPEND="${DEPEND}
	sources_standalone? ( !=sys-kernel/linux-argent-${PVR} )
	!sources_standalone? ( =sys-kernel/linux-argent-${PVR} )"
