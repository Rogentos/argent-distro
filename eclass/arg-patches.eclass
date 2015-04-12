# Copyright 2014 Sabayon
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# @ECLASS: arg-patches.eclass
# @MAINTAINER:
# slawomir.nizio@sabayon.org
# @AUTHOR:
# Sławomir Nizio <slawomir.nizio@sabayon.org>
# @BLURB: eclass that makes it easier to apply patches from multiple packages
# @DESCRIPTION:
# Makes it easy to apply patches stored in a remote location
# with the intention to make the task easier for Sabayon split ebuilds.
# (Plain patches kept in a VCS are very nice, but in the case of split
# ebuilds, duplicating the patches is not effective.)
# Patches are not added to SRC_URI by default, because it makes ebuilds
# use "SRC_URI+=..." which makes them more diverged from the original
# one than necessary.
# The eclass does not define any phase function.

# @ECLASS-VARIABLE: SAB_PATCHES_SRC
# @DEFAULT_UNSET
# @DESCRIPTION:
# Array that contains URIs of patches to be added to SRC_URI. Mandatory!

# @ECLASS-VARIABLE: SAB_PATCHES_SKIP
# @DESCRIPTION:
# Array that contains patterns of patch names to be skipped.
# It does not need to be a global variable.

inherit eutils

if [[ ${#SAB_PATCHES_SRC[@]} -eq 0 ]]; then
	die "SAB_PATCHES_SRC is not set"
fi

# @FUNCTION: arg-patches_update_SRC_URI
# @DESCRIPTION:
# Appends patches entries to SRC_URI. If it is not done, an error will
# occur later on.
arg-patches_update_SRC_URI() {
	local p
	for p in "${SAB_PATCHES_SRC[@]}"; do
		SRC_URI+=${SRC_URI:+ }${p}
	done
}

# @FUNCTION: arg-patches_apply_all
# @DESCRIPTION:
# Applies patches specified using SAB_PATCHES_SRC, skipping patches
# with names matched in SAB_PATCHES_SKIP.
# Two possible cases are supported.
# 1. A patch path which is a tarball (assumed file name: *.tar*).
# Such a tarball must unpack to ${WORKDIR}/<tarball name without *.tar*>
# and must contain a file 'order,' which is used to determine order
# of patches to apply.
# 2. A patch which is not a tarball, which will be simply applied (if
# it is not skipped).
arg-patches_apply_all() {
	local p
	for p in "${SAB_PATCHES_SRC[@]}"; do
		if [[ ${p} = *.tar* ]]; then
			local dir=${p##*/}
			dir=${dir%.tar*}
			_arg-patches_apply_from_dir "${WORKDIR}/${dir}"
		else
			local name=${p##*/}
			_arg-patches_apply_nonskipped "${DISTDIR}" "${name}"
		fi
	done
}

# @FUNCTION: arg-patches_apply
# @DESCRIPTION:
# Apply selected patches. Arguments are the directory containing
# the patch, followed by one or more patch names.
arg-patches_apply() {
	[[ $# -lt 2 ]] && die "arg-patches_apply: missing arguments"
	local dir=$1
	shift
	local patch
	for patch; do
		epatch "${dir}/${patch}"
	done
}

# @FUNCTION: arg-patches_unpack
# @DESCRIPTION:
# Unpack every file provided in SAB_PATCHES_SRC.
arg-patches_unpack() {
	local p
	pushd "${WORKDIR}" > /dev/null || die

	for p in "${SAB_PATCHES_SRC[@]}"; do
		local name=${p##*/}
		unpack "${name}"
	done

	popd > /dev/null || die
}

# @FUNCTION: _arg-patches_apply_nonskipped
# @INTERNAL
# @DESCRIPTION:
# Apply selected patches - only those which should not be skipped.
# Arguments are the directory containing the patch, followed by
# one or more patch names.
# This function is not intended to be used by ebuilds because there
# is a better way: use arg-patches_apply and skip the unwanted ones.
_arg-patches_apply_nonskipped() {
	if [[ $# -lt 2 ]]; then
		die "_arg-patches_apply_nonskipped: missing arguments"
	fi

	local dir=$1
	shift

	local patch
	for patch; do
		if [[ ${patch} = */* ]]; then
			die "_arg-patches_apply_nonskipped: '${patch}' contains slashes"
		fi

		if _arg-patches_is_skipped "${patch}"; then
			einfo "(skipping ${patch})"
		else
			epatch "${dir}/${patch}"
		fi
	done
}

# @FUNCTION: _arg-patches_apply_from_dir
# @INTERNAL
# @DESCRIPTION:
# Apply all patches from a directory in order. Obeys SAB_PATCHES_SKIP.
_arg-patches_apply_from_dir() {
	local dir=$1
	local order_file=${dir}/order
	if [[ ! -r ${order_file} ]] || [[ ! -f ${order_file} ]]; then
		die "Problems with '${order_file}'... (Does it exist?)"
	fi

	local patch
	while read patch; do
		local patch_path=${dir}/${patch}
		if \
			[[ -z ${patch} ]]    || \
			[[ ${patch} = *\ * ]] || \
			[[ ${patch} = */* ]] || \
			[[ ! -f ${patch_path} ]]; then
			die "Problems with the patch '${patch}', see ${order_file}."
		fi

		_arg-patches_apply_nonskipped "${dir}" "${patch}"
	done < "${order_file}"

	[[ $? -ne 0 ]] && die "_arg-patches_apply_from_dir: loop failed"
}

# @FUNCTION: _arg-patches_is_skipped
# @INTERNAL
# @DESCRIPTION:
# Returns success if the patch should be skipped. O(n). :)
_arg-patches_is_skipped() {
	local arg=$1
	local p
	for p in "${SAB_PATCHES_SKIP[@]}"; do
		[[ ${arg} = ${p} ]] && return 0
	done
	return 1
}
