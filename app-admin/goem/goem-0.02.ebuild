EAPI=4

inherit git-2

DESCRIPTION=""
HOMEPAGE=""
SRC_URI=""

LICENSE="BeerBSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-lang/go"

RDEPEND="${DEPEND}"

EGIT_REPO_URI="https://github.com/adeven/goem.git"
EGIT_BRANCH="master"

src_compile() {
	mkdir "${PORTAGE_BUILDDIR}/work/goem-0.02/build_dir"
	go build -o build_dir/goem || die "$!"
}

src_install() {
    dodir /usr/bin/
	cp "${PORTAGE_BUILDDIR}/work/goem-0.02/build_dir/goem" \
	"${D}/usr/bin/" || die
}

