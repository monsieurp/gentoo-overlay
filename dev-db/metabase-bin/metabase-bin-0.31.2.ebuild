# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit user

DESCRIPTION="A java DB query builder and visualizer"
HOMEPAGE="https://www.metabase.com/"

MY_PN="metabase"
MY_P="v${PV}"
SRC_URI="http://downloads.${MY_PN}.com/${MY_P}/${MY_PN}.jar -> ${P}.jar"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	virtual/jre:1.8
"

DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"
INSTALL_DIR="/opt/${MY_PN}"

pkg_setup() {
	enewgroup metabase
	enewuser metabase -1 -1 /opt/metabase metabase
}

src_unpack() {
	#cp because we don't actually unpack jars
	mkdir -p "${WORKDIR}/${MY_P}/bin" || die
	mkdir -p "${WORKDIR}/${MY_P}/lib" || die

	cp "${DISTDIR}/${P}.jar" "${WORKDIR}/${MY_P}/bin/${PN}.jar" || die
	cp "${FILESDIR}/metabase-server-start.sh" \
		"${WORKDIR}/${MY_P}/bin" || die
	cp "${FILESDIR}/metabase-log4j.properties" \
		"${WORKDIR}/${MY_P}/lib/log4j.properties" || die
}

src_install() {
	keepdir /var/log/metabase
	fowners metabase:metabase /var/log/metabase

	dodir "${INSTALL_DIR}/"
	cp -pRP * "${ED}/${INSTALL_DIR}" || die
	fowners -R metabase:metabase "${INSTALL_DIR}"
	fperms o-x "${INSTALL_DIR}/bin/metabase-server-start.sh"

	newinitd "${FILESDIR}/metabase-init.d" "${MY_PN}"
	newconfd "${FILESDIR}/metabase-conf.d" "${MY_PN}"
}
