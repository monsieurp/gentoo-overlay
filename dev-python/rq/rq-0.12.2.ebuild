# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python3_5 python3_6 )

inherit distutils-r1 vcs-snapshot

DESCRIPTION="RQ (Redis Queue)"
HOMEPAGE="https://github.com/AcquiredIO/rq"
LICENSE="rq"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86"

if [[ "${PV}" == "9999" ]]; then
	EGIT_REPO_URI="${HOMEPAGE}"
	inherit git-r3
else
	SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
fi

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
"
RDEPEND="
	dev-python/redis-py[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
"
