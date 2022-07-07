# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	aho-corasick-0.7.18
	ansi_term-0.12.1
	anyhow-1.0.57
	assert_cmd-2.0.4
	atty-0.2.14
	autocfg-1.1.0
	bitflags-1.3.2
	bstr-0.2.17
	clap-3.1.18
	clap_lex-0.2.0
	const_format-0.2.23
	const_format_proc_macros-0.2.22
	difflib-0.4.0
	doc-comment-0.3.3
	either-1.6.1
	float-cmp-0.9.0
	hashbrown-0.11.2
	hermit-abi-0.1.19
	indexmap-1.8.1
	itertools-0.10.3
	lazy_static-1.4.0
	libc-0.2.126
	memchr-2.5.0
	normalize-line-endings-0.3.0
	num-traits-0.2.15
	os_str_bytes-6.0.1
	predicates-2.1.1
	predicates-core-1.0.3
	predicates-tree-1.0.5
	proc-macro2-1.0.39
	quote-1.0.18
	regex-1.5.6
	regex-automata-0.1.10
	regex-syntax-0.6.26
	strsim-0.10.0
	syn-1.0.95
	termcolor-1.1.3
	terminal_size-0.1.17
	termtree-0.2.4
	textwrap-0.15.0
	thiserror-1.0.31
	thiserror-impl-1.0.31
	unicode-ident-1.0.0
	unicode-xid-0.2.3
	wait-timeout-0.2.0
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
"

inherit cargo

DESCRIPTION="A command-line hex viewer"
HOMEPAGE="https://github.com/sharkdp/hexyl"
SRC_URI="
	https://github.com/sharkdp/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	$(cargo_crate_uris)
"

LICENSE="Apache-2.0 MIT ZLIB"
SLOT="0"
KEYWORDS="~amd64"

QA_FLAGS_IGNORES="usr/bin/${PN}"

DOCS=( README.md CHANGELOG.md )

src_install() {
	cargo_src_install
	einstalldocs
}
