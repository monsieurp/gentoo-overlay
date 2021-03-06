# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{3_5,3_6} )
inherit distutils-r1

DESCRIPTION="Compresses linked and inline JavaScript or CSS into single cached files."
HOMEPAGE="https://pypi.org/project/django-compressor/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
"
RDEPEND="
	dev-python/django-appconf[${PYTHON_USEDEP}]
	dev-python/rcssmin[${PYTHON_USEDEP}]
	dev-python/rjsmin[${PYTHON_USEDEP}]
"
