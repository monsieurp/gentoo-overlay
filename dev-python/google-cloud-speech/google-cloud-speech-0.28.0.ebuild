# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{2_7,3_4,3_5,3_6} )
inherit distutils-r1

HOMEPAGE='https://github.com/GoogleCloudPlatform/google-cloud-python'
DESCRIPTION='Python Client for Google Cloud Speech'
SLOT='0'
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE='Apache-2.0'
SLOT='0'
KEYWORDS='~amd64'
IUSE=''

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="
    dev-python/grpcio[${PYTHON_USEDEP}]
    dev-python/google-gax[${PYTHON_USEDEP}]
    dev-python/googleapis-common-protos[${PYTHON_USEDEP}]
    dev-python/google-cloud-core[${PYTHON_USEDEP}]
"
