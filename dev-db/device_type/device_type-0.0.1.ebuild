# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

POSTGRES_COMPAT=( 9.4 9.5 9.6 10 )

inherit postgres-multi

DESCRIPTION="Integers with base36 presentation"
HOMEPAGE="https://github.com/adjust/pg-device_type"
SRC_URI="https://api.pgxn.org/dist/device_type/${PV}/device_type-${PV}.zip"
LICENSE="POSTGRESQL GPL-2"

KEYWORDS="~amd64"

SLOT=0

RESTRICT="test" # connects to local DB instance, which is bad

src_compile() {
	postgres-multi_foreach emake USE_PGXS=1
}

src_install() {
	postgres-multi_foreach emake DESTDIR="${D}" USE_PGXS=1 install
}
