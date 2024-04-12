# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools

DESCRIPTION="Statistical analysis and machine learning library"
HOMEPAGE="https://statpatrec.sourceforge.net/"
SRC_URI="https://downloads.sourceforge.net/statpatrec/${P^^}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"

IUSE="root static-libs"

DEPEND="root? ( sci-physics/root )"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${P^^}
PATCHES=(
	"${FILESDIR}"/${P}-autotools.patch
	"${FILESDIR}"/${P}-gcc46.patch
	"${FILESDIR}"/${P}-fix-c++14.patch
)

src_prepare() {
	default
	rm aclocal.m4 || die
	eautoreconf
	cp data/gauss* src/ || die
}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		$(use_with root)
}
