# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{6,7} )
inherit distutils-r1

DESCRIPTION="This is an unofficial Python API for Bamboo HR."
HOMEPAGE="https://pypi.org/project/PyBambooHR/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-python/httpretty[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/xmltodict[${PYTHON_USEDEP}]
"
