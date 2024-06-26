# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Autogenerated by pycargoebuild 0.6.3

EAPI=8

CRATES="
	adler@1.0.2
	ahash@0.8.11
	allocator-api2@0.2.16
	anstream@0.6.13
	anstyle@1.0.6
	anstyle-parse@0.2.3
	anstyle-query@1.0.2
	anstyle-wincon@3.0.2
	anyhow@1.0.81
	arc-swap@1.7.1
	autocfg@1.2.0
	bitflags@1.3.2
	bitflags@2.5.0
	bstr@1.9.1
	bzip2-rs@0.1.2
	cc@1.0.90
	cfg-if@1.0.0
	cfg_aliases@0.1.1
	clap@4.5.4
	clap_builder@4.5.2
	clap_lex@0.7.0
	clru@0.6.1
	colorchoice@1.0.0
	crc32fast@1.4.0
	ctrlc@3.4.4
	curl@0.4.46
	curl-sys@0.4.72+curl-8.6.0
	deranged@0.3.11
	dunce@1.0.4
	encoding_rs@0.8.33
	equivalent@1.0.1
	errno@0.3.8
	faster-hex@0.9.0
	fastrand@2.0.2
	filetime@0.2.23
	flate2@1.0.28
	fnv@1.0.7
	form_urlencoded@1.2.1
	gix@0.61.0
	gix-actor@0.31.1
	gix-bitmap@0.2.11
	gix-chunk@0.4.8
	gix-command@0.3.6
	gix-commitgraph@0.24.2
	gix-config@0.36.0
	gix-config-value@0.14.6
	gix-date@0.8.5
	gix-diff@0.42.0
	gix-discover@0.31.0
	gix-features@0.38.1
	gix-fs@0.10.1
	gix-glob@0.16.2
	gix-hash@0.14.2
	gix-hashtable@0.5.2
	gix-index@0.31.1
	gix-lock@13.1.1
	gix-macros@0.1.4
	gix-object@0.42.1
	gix-odb@0.59.0
	gix-pack@0.49.0
	gix-path@0.10.7
	gix-quote@0.4.12
	gix-ref@0.43.0
	gix-refspec@0.23.0
	gix-revision@0.27.0
	gix-revwalk@0.13.0
	gix-sec@0.10.6
	gix-tempfile@13.1.1
	gix-trace@0.1.8
	gix-traverse@0.38.0
	gix-url@0.27.2
	gix-utils@0.1.11
	gix-validate@0.8.4
	hashbrown@0.14.3
	hermit-abi@0.3.9
	home@0.5.9
	idna@0.5.0
	indexmap@2.2.6
	is-terminal@0.4.12
	itoa@1.0.11
	libc@0.2.153
	libz-sys@1.1.16
	linux-raw-sys@0.4.13
	lock_api@0.4.11
	memchr@2.7.2
	memmap2@0.9.4
	minimal-lexical@0.2.1
	miniz_oxide@0.7.2
	nix@0.28.0
	nom@7.1.3
	num-conv@0.1.0
	num_threads@0.1.7
	once_cell@1.19.0
	openssl-probe@0.1.5
	openssl-sys@0.9.102
	parking_lot@0.12.1
	parking_lot_core@0.9.9
	percent-encoding@2.3.1
	pkg-config@0.3.30
	powerfmt@0.2.0
	proc-macro2@1.0.79
	prodash@28.0.0
	quote@1.0.35
	redox_syscall@0.4.1
	regex-automata@0.4.6
	rustix@0.38.32
	ryu@1.0.17
	same-file@1.0.6
	schannel@0.1.23
	scopeguard@1.2.0
	serde@1.0.197
	serde_derive@1.0.197
	serde_json@1.0.115
	sha1_smol@1.0.0
	shell-words@1.1.0
	smallvec@1.13.2
	socket2@0.5.6
	strsim@0.11.1
	syn@2.0.58
	tar@0.4.40
	tempfile@3.10.1
	termcolor@1.4.1
	terminal_size@0.3.0
	thiserror@1.0.58
	thiserror-impl@1.0.58
	time@0.3.34
	time-core@0.1.2
	time-macros@0.2.17
	tinyvec@1.6.0
	tinyvec_macros@0.1.1
	unicode-bidi@0.3.15
	unicode-bom@2.0.3
	unicode-ident@1.0.12
	unicode-normalization@0.1.23
	url@2.5.0
	utf8parse@0.2.1
	vcpkg@0.2.15
	version_check@0.9.4
	walkdir@2.5.0
	winapi@0.3.9
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.6
	winapi-x86_64-pc-windows-gnu@0.4.0
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-targets@0.48.5
	windows-targets@0.52.4
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.4
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.4
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.4
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.4
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.4
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.4
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.4
	winnow@0.6.5
	xattr@1.3.1
	zerocopy@0.7.32
	zerocopy-derive@0.7.32
"

inherit cargo flag-o-matic

DESCRIPTION="Stack-based patch management for Git"
HOMEPAGE="https://stacked-git.github.io/"
SRC_URI="${CARGO_CRATE_URIS}"
SRC_URI+=" https://github.com/stacked-git/stgit/releases/download/v${PV}/${P}.tar.gz"

LICENSE="GPL-2"
# Dependent crate licenses
LICENSE+=" Apache-2.0 BSD MIT Unicode-DFS-2016"
SLOT="0/2"
KEYWORDS="amd64 arm arm64 ppc ppc64 ~riscv x86"
IUSE="doc"

DEPEND="doc? ( app-text/asciidoc )"

# rust does not use *FLAGS from make.conf, silence portage warning
# update with proper path to binaries this crate installs, omit leading /
QA_FLAGS_IGNORED="usr/bin/stg"

src_configure() {
	filter-lto #bug 897692
}

src_compile() {
	cargo_src_compile
	emake completion
	emake contrib
	use doc && emake doc
}

src_install() {
	cargo_src_install
	emake DESTDIR="${D}" prefix="/usr" install-completion
	emake DESTDIR="${D}" prefix="/usr" install-contrib
	if use doc; then
		emake DESTDIR="${D}" prefix="/usr" install-man
		emake DESTDIR="${D}" prefix="/usr" \
			htmldir="/usr/share/doc/${PF}"  \
			install-html
	fi
}
