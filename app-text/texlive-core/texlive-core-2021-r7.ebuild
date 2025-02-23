# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

TL_SOURCE_VERSION=20210325

# autotools/reautoconf in src_prepare only needed for Cairo patch
inherit autotools flag-o-matic toolchain-funcs libtool texlive-common

MY_P=${PN%-core}-${TL_SOURCE_VERSION}-source

PATCHLEVEL=1

DESCRIPTION="A complete TeX distribution"
HOMEPAGE="https://tug.org/texlive/"
SLOT="0"
LICENSE="GPL-2 LPPL-1.3c TeX"

SRC_URI="
	https://dev.gentoo.org/~sam/distfiles/texlive/${MY_P}.tar.xz
	https://dev.gentoo.org/~sam/distfiles/texlive/texlive-tlpdb-${PV}.tar.xz
	https://dev.gentoo.org/~sam/distfiles/texlive/${PN}-patches-${PV}-${PATCHLEVEL}.tar.xz
	https://dev.gentoo.org/~sam/distfiles/${CATEGORY}/${PN}/texlive-core-2021-CVE-2023-32700.patch.xz
"

# We ship binextra collection alongside
TL_CORE_BINEXTRA_MODULES="
	a2ping adhocfilelist arara asymptote bundledoc checklistings chklref ctan_chk
	clojure-pamphlet cluttex ctanify ctan-o-mat ctanbib ctanupload ctie cweb de-macro
	dtl dtxgen dvi2tty dviasm dvicopy dvidvi dviinfox dviout-util dviljk dvipos findhyph
	fragmaster hook-pre-commit-pkg installfont ketcindy lacheck latex-git-log latex-papersize
	latex2man latex2nemeth latexfileversion latexpand latexindent ltxfileinfo ltximg
	listings-ext make4ht match_parens mflua mkjobtexmf patgen pdfbook2 pdfcrop pdfjam
	pdflatexpicscale pdftex-quiet pdfxup pdftosrc pfarrei pkfix pkfix-helper purifyeps
	seetexk spix srcredact sty2dtx synctex tex4ebook texcount texdef texdiff texdirflatten
	texdoc texfot texliveonfly texlive-scripts-extra texloganalyser texosquery texplate
	texware tie tlcockpit tpic2pdftex typeoutfileinfo web xindy xindex xpdfopen collection-binextra
	"
TL_CORE_BINEXTRA_DOC_MODULES="
	a2ping.doc adhocfilelist.doc arara.doc asymptote.doc bundledoc.doc
	checklistings.doc chklref.doc ctan_chk.doc clojure-pamphlet.doc cluttex.doc
	ctanify.doc ctan-o-mat.doc ctanbib.doc ctanupload.doc ctie.doc cweb.doc de-macro.doc
	dtl.doc dtxgen.doc dvi2tty.doc dviasm.doc dvicopy.doc dvidvi.doc dviinfox.doc dviljk.doc
	dvipos.doc dviout-util.doc findhyph.doc fragmaster.doc hook-pre-commit-pkg.doc installfont.doc
	ketcindy.doc lacheck.doc latex-git-log.doc latex-papersize.doc latex2man.doc latex2nemeth.doc
	latexfileversion.doc latexpand.doc latexindent.doc ltxfileinfo.doc ltximg.doc listings-ext.doc
	make4ht.doc match_parens.doc mkjobtexmf.doc patgen.doc pdfbook2.doc pdfcrop.doc pdfjam.doc
	pdflatexpicscale.doc pdftex-quiet.doc pdfxup.doc pdftosrc.doc pfarrei.doc pkfix.doc
	pkfix-helper.doc purifyeps.doc pythontex.doc seetexk.doc spix.doc srcredact.doc
	sty2dtx.doc synctex.doc tex4ebook.doc texcount.doc texdef.doc texdiff.doc
	texdirflatten.doc texdoc.doc texfot.doc texliveonfly.doc texlive-scripts-extra.doc
	texloganalyser.doc texosquery.doc texware.doc tie.doc tlcockpit.doc tpic2pdftex.doc
	typeoutfileinfo.doc texplate.doc web.doc xindy.doc xindex.doc xpdfopen.doc
"
TL_CORE_BINEXTRA_SRC_MODULES="
	adhocfilelist.source arara.source checklistings.source clojure-pamphlet.source
	listings-ext.source mkjobtexmf.source pfarrei.source pythontex.source
	texdef.source texosquery.source texplate.source tlcockpit.source
"
# Macros that are not a part of texlive-sources or collection-binextra but still needed
# for other packages during installation
TL_CORE_EXTRA_MODULES="hyphen-base gsftopk texlive.infra texlive-scripts ${TL_CORE_BINEXTRA_MODULES}"
TL_CORE_EXTRA_DOC_MODULES="gsftopk.doc texlive.infra.doc texlive-scripts.doc ${TL_CORE_BINEXTRA_DOC_MODULES}"
TL_CORE_EXTRA_SRC_MODULES="${TL_CORE_BINEXTRA_SRC_MODULES}"

for i in ${TL_CORE_EXTRA_MODULES}; do
	SRC_URI="${SRC_URI} https://dev.gentoo.org/~sam/distfiles/texlive/tl-${i}-${PV}.tar.xz"
done

SRC_URI="${SRC_URI} doc? ( "
for i in ${TL_CORE_EXTRA_DOC_MODULES}; do
	SRC_URI="${SRC_URI} https://dev.gentoo.org/~sam/distfiles/texlive/tl-${i}-${PV}.tar.xz"
done
SRC_URI="${SRC_URI} )"
SRC_URI="${SRC_URI} source? ( "
for i in ${TL_CORE_EXTRA_SRC_MODULES}; do
	SRC_URI="${SRC_URI} https://dev.gentoo.org/~sam/distfiles/texlive/tl-${i}-${PV}.tar.xz"
done
SRC_URI="${SRC_URI} )"

KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~loong ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86 ~amd64-linux ~x86-linux ~sparc-solaris ~sparc64-solaris"
IUSE="cjk X doc source tk +luajittex xetex xindy"

TEXMF_PATH=/usr/share/texmf-dist

MODULAR_X_DEPEND="X? (
				x11-libs/libX11
				x11-libs/libXmu
	)"

COMMON_DEPEND="${MODULAR_X_DEPEND}
	!app-text/epspdf
	!app-text/pdfjam
	sys-libs/zlib
	>=media-libs/harfbuzz-1.4.5:=[icu,graphite]
	>=media-libs/libpng-1.2.43-r2:0=
	media-libs/gd[png]
	media-gfx/graphite2
	>=x11-libs/cairo-1.12
	>=x11-libs/pixman-0.18
	dev-libs/zziplib:=
	app-text/libpaper:=
	dev-libs/gmp:=
	dev-libs/mpfr:=
	>=dev-libs/ptexenc-1.3.8
	xetex? (
		>=app-text/teckit-2.5.3
		media-libs/fontconfig
	)
	xindy? ( dev-lisp/clisp:= )
	media-libs/freetype:2
	>=dev-libs/icu-50:=
	>=dev-libs/kpathsea-6.3.2:="

BDEPEND="sys-apps/ed
	sys-devel/flex
	virtual/pkgconfig"

DEPEND="${COMMON_DEPEND}"

RDEPEND="${COMMON_DEPEND}
	>=app-text/ps2pkm-1.8_p20170524
	>=app-text/dvipsk-5.997
	>=dev-tex/bibtexu-3.71_p20170524
	virtual/perl-Getopt-Long
	dev-perl/File-HomeDir
	dev-perl/Log-Dispatch
	dev-perl/Unicode-LineBreak
	dev-perl/YAML-Tiny
	tk? (
	dev-lang/tk
	dev-perl/Tk
	)"

S="${WORKDIR}/${P}_build"
B="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	mkdir -p "${S}" || die "failed to create build dir"
}

RELOC_TARGET=texmf-dist

src_prepare() {
	cd "${WORKDIR}" || die

	mv texlive.tlpdb tlpkg/ || die "failed to move texlive.tlpdb"

	# From texlive-module.eclass.
	sed -n -e 's:\s*RELOC/::p' tlpkg/tlpobj/* > "${T}/reloclist" || die
	sed -e 's/\/[^/]*$//' -e "s:^:${RELOC_TARGET}/:" "${T}/reloclist" |
		sort -u |
		xargs mkdir -p || die
	local i
	while read i; do
		mv "${i}" "${RELOC_TARGET}/${i%/*}" || die
	done < "${T}/reloclist"

	mv "${WORKDIR}"/texmf* "${B}" || die "failed to move texmf files"

	cd "${B}" || die

	sed -i \
		-e "s,/usr/include /usr/local/include.*echo \$KPATHSEA_INCLUDES.*,${EPREFIX}/usr/include\"," \
		texk/web2c/configure || die

	eapply "${WORKDIR}"/patches
	eapply "${FILESDIR}"/${P}-cairo-strings.patch
	eapply "${FILESDIR}"/${P}-slibtool.patch
	eapply "${FILESDIR}"/${P}-clang-16.patch
	eapply "${WORKDIR}"/${P}-CVE-2023-32700.patch

	default

	elibtoolize

	# Drop this on 2022 bump!
	"${B}"/reautoconf libs/cairo || die
}

src_configure() {
	# It fails on alpha without this
	use alpha && append-ldflags "-Wl,--no-relax"

	# Too many regexps use A-Z a-z constructs, what causes problems with locales
	# that don't have the same alphabetical order than ascii. Bug #242430
	# So we set LC_ALL to C in order to avoid problems.
	export LC_ALL=C

	# Disable freetype-config as this is considered obsolete.
	# Also only pkg-config works for prefix as described in bug #690094
	export ac_cv_prog_ac_ct_FT2_CONFIG=no

	# revisit/upstream once we bupm to 2022, bug #882245
	append-cppflags -D_GNU_SOURCE

	tc-export CC CXX AR RANLIB
	ECONF_SOURCE="${B}" \
		econf -C \
		--bindir="${EPREFIX}"/usr/bin \
		--datadir="${S}" \
		--with-system-freetype2 \
		--with-system-zlib \
		--with-system-libpng \
		--with-system-teckit \
		--with-teckit-includes="${EPREFIX}"/usr/include/teckit \
		--with-system-kpathsea \
		--with-kpathsea-includes="${EPREFIX}"/usr/include \
		--with-system-icu \
		--with-system-ptexenc \
		--with-system-harfbuzz \
		--with-system-icu \
		--with-system-graphite2 \
		--with-system-cairo \
		--with-system-pixman \
		--with-system-zziplib \
		--with-system-libpaper \
		--with-system-gmp \
		--with-system-gd \
		--with-system-mpfr \
		--without-texinfo \
		--disable-dialog \
		--disable-multiplatform \
		--enable-chktex \
		--enable-epsfwin \
		--enable-detex \
		--enable-dvi2tty \
		--enable-mftalkwin \
		--enable-regiswin \
		--enable-shared \
		--enable-tektronixwin \
		--enable-unitermwin \
		--enable-vlna \
		--with-ps=gs \
		--disable-psutils \
		--disable-t1utils \
		--enable-ipc \
		--disable-biber \
		--disable-bibtex-x \
		--disable-dvipng \
		--disable-dvipsk \
		--disable-lcdf-typetools \
		--disable-ps2pk \
		--disable-ttf2pk2 \
		--disable-tex4htk \
		--disable-cjkutils \
		--disable-xdvik \
		--enable-luatex \
		--disable-dvisvgm \
		--disable-ps2eps \
		--disable-static \
		--disable-native-texlive-build \
		--disable-largefile \
		--disable-build-in-source-tree \
		--disable-xindy-docs \
		--disable-xindy-rules \
		--with-banner-add=" Gentoo Linux" \
		$(use_enable luajittex) \
		$(use_enable luajittex luajithbtex) \
		$(use_enable luajittex mfluajit) \
		$(use_enable xetex) \
		$(use_enable cjk dviout-util) \
		$(use_enable cjk ptex) \
		$(use_enable cjk eptex) \
		$(use_enable cjk uptex) \
		$(use_enable cjk euptex) \
		$(use_enable cjk mendexk) \
		$(use_enable cjk makejvf) \
		$(use_enable cjk pmp) \
		$(use_enable cjk upmp) \
		$(use_enable tk texdoctk) \
		$(use_with X x) \
		$(use_enable xindy)
}

src_compile() {
	tc-export CC CXX AR RANLIB

	emake AR="$(tc-getAR)" SHELL="${EPREFIX}"/bin/sh texmf="${EPREFIX}"${TEXMF_PATH:-/usr/share/texmf-dist}

	cd "${B}" || die
	# Mimic updmap --syncwithtrees to enable only fonts installed
	# Code copied from updmap script
	for i in `grep -E '^(Mixed|Kanji)?Map' "texmf-dist/web2c/updmap.cfg" | sed 's@.* @@'`; do
		texlive-common_is_file_present_in_texmf "${i}" || echo "${i}"
	done > "${T}/updmap_update"
	{
		sed 's@/@\\/@g; s@^@/^MixedMap[     ]*@; s@$@$/s/^/#! /@' <"${T}/updmap_update"
		sed 's@/@\\/@g; s@^@/^Map[  ]*@; s@$@$/s/^/#! /@' <"${T}/updmap_update"
		sed 's@/@\\/@g; s@^@/^KanjiMap[     ]*@; s@$@$/s/^/#! /@' <"${T}/updmap_update"
	} > "${T}/updmap_update2"
	sed -f "${T}/updmap_update2" "texmf-dist/web2c/updmap.cfg" >	"${T}/updmap_update3"\
		&& cat "${T}/updmap_update3" > "texmf-dist/web2c/updmap.cfg"
}

src_install() {
	dodir ${TEXMF_PATH:-/usr/share/texmf-dist}/web2c

	emake DESTDIR="${D}" texmf="${ED}${TEXMF_PATH:-/usr/share/texmf-dist}" run_texlinks="true" run_mktexlsr="true" install

	cd "${B}" || die
	dodir /usr/share # just in case
	cp -pR texmf-dist "${ED}/usr/share/" || die "failed to install texmf trees"
	cp -pR "${WORKDIR}"/tlpkg "${ED}/usr/share/" || die "failed to install tlpkg files"

	# When X is disabled mf-nowin doesn't exist but some scripts expect it to
	# exist. Instead, it is called mf, so we symlink it to please everything.
	use X || dosym mf /usr/bin/mf-nowin

	docinto texk
	cd "${B}/texk" || die
	dodoc ChangeLog README

	docinto dviljk
	cd "${B}/texk/dviljk" || die
	dodoc ChangeLog README NEWS

	docinto makeindexk
	cd "${B}/texk/makeindexk" || die
	dodoc ChangeLog NOTES README

	docinto web2c
	cd "${B}/texk/web2c" || die
	dodoc ChangeLog NEWS PROJECTS README

	use doc || rm -rf "${ED}/usr/share/texmf-dist/doc"

	dodir /etc/env.d
	echo 'CONFIG_PROTECT_MASK="/etc/texmf/web2c /etc/texmf/language.dat.d /etc/texmf/language.def.d /etc/texmf/updmap.d"' > "${ED}/etc/env.d/98texlive"
	# populate /etc/texmf
	keepdir /etc/texmf/web2c

	# take care of updmap.cfg and language.d files
	keepdir /etc/texmf/{updmap.d,language.dat.d,language.def.d,language.dat.lua.d}

	mv "${ED}${TEXMF_PATH}/web2c/updmap.cfg" "${ED}/etc/texmf/updmap.d/00updmap.cfg" || die "moving updmap.cfg failed"

	# Remove fmtutil.cnf, it will be regenerated from /etc/texmf/fmtutil.d files
	# by texmf-update
	rm -f "${ED}${TEXMF_PATH}/web2c/fmtutil.cnf" || die
	# Remove bundled and invalid updmap.cfg
	rm -f "${ED}/usr/share/texmf-dist/web2c/updmap.cfg" || die

	texlive-common_handle_config_files

	keepdir /usr/share/texmf-site

	# the virtex symlink is not installed
	# The links has to be relative, since the targets
	# is not present at this stage and MacOS doesn't
	# like non-existing targets
	dosym tex /usr/bin/virtex
	dosym pdftex /usr/bin/pdfvirtex

	find "${ED}" -name '*.la' -delete || die
}

pkg_postinst() {
	etexmf-update

	einfo "Regenerating TeX formats"
	fmtutil-sys --all &> /dev/null

	elog
	elog "If you have configuration files in ${EPREFIX}/etc/texmf to merge,"
	elog "please update them and run ${EPREFIX}/usr/sbin/texmf-update."
	elog

	local display_migration_hint=false
	if [[ -n ${REPLACING_VERSIONS} ]]; then
		local new_texlive_ver=$(ver_cut 1)
		local replaced_version
		for replaced_version in ${REPLACING_VERSIONS}; do
			replaced_version=$(ver_cut 1 ${replaced_version})
			if (( replaced_version < new_texlive_version )); then
				display_migration_hint=true
				break
			fi
		done
	fi

	if ! ${display_migration_hint}; then
		return
	fi

	ewarn "If you are migrating from an older TeX distribution"
	ewarn "Please make sure you have read:"
	ewarn "https://wiki.gentoo.org/wiki/Project:TeX/Tex_Live_Migration_Guide"
	ewarn "in order to avoid possible problems"
}
