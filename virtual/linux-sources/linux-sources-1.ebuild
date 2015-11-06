# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Argent Virtual package for Linux kernel sources"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="firmware"

DEPEND="firmware? ( sys-kernel/linux-firmware )"
RDEPEND="sys-kernel/argent-sources"
