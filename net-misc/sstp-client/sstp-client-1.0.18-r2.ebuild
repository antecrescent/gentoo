# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools linux-info

DESCRIPTION="Client implementation of Secure Socket Tunneling Protocol (SSTP)"
HOMEPAGE="https://sstp-client.sourceforge.net/"
SRC_URI="mirror://sourceforge/sstp-client/${P}.tar.gz"
SRC_URI+=" https://dev.gentoo.org/~sam/distfiles/${CATEGORY}/${PN}/${P}-ppp-2.5.0-patches.tar.xz"

LICENSE="GPL-2+-with-openssl-exception"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE="static"

DEPEND="dev-libs/libevent:=
	dev-libs/openssl:=
	net-dialup/ppp:=[ipv6(+)]"
RDEPEND="${DEPEND}
	acct-group/sstpc
	acct-user/sstpc"
BDEPEND="virtual/pkgconfig"

CONFIG_CHECK="~NETFILTER_NETLINK"

DOCS=( AUTHORS ChangeLog DEVELOPERS NEWS README TODO USING )

PATCHES=(
	"${FILESDIR}/${PN}-1.0.12-remove-network-test.patch"
	"${FILESDIR}/${PN}-1.0.12-fix-example.patch"

	"${FILESDIR}/${PN}-1.0.18-includes.patch"
	"${WORKDIR}/${P}-ppp-2.5.0-patches"
	"${FILESDIR}/sstp-client-1.0.18-sstp-mppe.patch"
)

src_prepare() {
	default

	eautoreconf
}

src_configure() {
	local PPPD_VER="$(best_version net-dialup/ppp)"
	# Reduce it to ${PV}-${PR}
	PPPD_VER=${PPPD_VER#*/*-}
	# Main version without beta/pre/patch/revision
	PPPD_VER=${PPPD_VER%%[_-]*}

	local myeconfargs=(
		--enable-ppp-plugin
		--enable-group=sstpc
		--enable-user=sstpc
		--with-pppd-plugin-dir="/usr/$(get_libdir)/pppd/${PPPD_VER}"
		--with-runtime-dir="/run/sstpc"
		$(use_enable static)
	)

	econf "${myeconfargs[@]}"
}

src_install() {
	default

	find "${ED}" -name '*.la' -delete || die
}
