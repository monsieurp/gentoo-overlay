# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="Apache Arrow and Parquet libraries"
LICENSE="Apache-2.0"
KEYWORDS="~amd64 ~x86"
HOMEPAGE="https://arrow.apache.org/"
SRC_URI="https://github.com/apache/arrow/archive/apache-arrow-${PV}.tar.gz"
SLOT="0"
DEPEND="dev-libs/boost"
RDEPEND="${DEPEND}"
S="${WORKDIR}/arrow-apache-arrow-${PV}"

CMAKE_BUILD_TYPE="release"
CMAKE_USE_DIR="${S}/cpp"
CMAKE_MAKEFILE_GENERATOR="emake"

src_configure() {
	local mycmakeargs=(
		-DARROW_PARQUET=ON
	)

	cmake-utils_src_configure
}
