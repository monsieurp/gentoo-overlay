EAPI=5
inherit perl-module
inherit git-2

DESCRIPTION=""
HOMEPAGE=""
SRC_URI=""
EGIT_REPO_URI="https://github.com/adeven/redis_failover.git"

SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="virtual/perl-Module-Build dev-perl/Moo dev-perl/Redis dev-perl/yaml"

RDEPEND="${DEPEND}"

src_install() {
	./Build install
}