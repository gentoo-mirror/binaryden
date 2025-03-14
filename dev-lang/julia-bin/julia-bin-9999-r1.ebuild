# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN=${PN/-bin/}

DESCRIPTION="High-performance programming language for technical computing"
HOMEPAGE="https://julialang.org/"
S="${WORKDIR}/"

PROPERTIES="live"
MY_P=${MY_PN}-latest

LICENSE="MIT"
SLOT="9999"
RESTRICT="strip"

RDEPEND="
	app-arch/p7zip
"
DEPEND="${RDEPEND}"

QA_PREBUILT="*"

src_unpack() {
	NIGHTLIES_S3="https://julialangnightlies-s3.julialang.org/bin"
	if use x86; then
		URI="${NIGHTLIES_S3}/linux/x86/${MY_P}-linux32.tar.gz"
	elif use amd64; then
		URI="${NIGHTLIES_S3}/linux/x64/${MY_P}-linux64.tar.gz"
	elif use arm64; then
		URI="${NIGHTLIES_S3}/linux/aarch64/${MY_P}-linuxaarch64.tar.gz"
	else
		die "arch not supported"
	fi

	wget -O "${T}/julia.tar.gz" "${URI}"
	unpack "${T}/julia.tar.gz"
}

src_install() {
	insinto "/usr/$(get_libdir)/${MY_P}/"
	doins -r ./julia-*/etc
	doins -r ./julia-*/include
	doins -r ./julia-*/lib
	doins -r ./julia-*/share

	exeinto "/usr/$(get_libdir)/${MY_P}/bin"
	doexe ./julia-*/bin/julia
	dosym "../$(get_libdir)/${MY_P}/bin/julia" "/usr/bin/julia${PV}"

	exeinto "/usr/$(get_libdir)/${MY_P}/libexec/julia/"
	doexe ./julia-*/libexec/julia/lld
}
