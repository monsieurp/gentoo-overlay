# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit user
MY_PN=${PN/-bin/}
S=${WORKDIR}/${MY_PN}-${PV}

DESCRIPTION="Gorgeous metric viz, dashboards & editors for Graphite, InfluxDB & OpenTSDB"
HOMEPAGE="http://grafana.org"
SRC_URI="https://grafanarel.s3.amazonaws.com/builds/${MY_PN}-${PV}.linux-x64.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	>=dev-lang/go-1.5
	net-libs/nodejs
"

pkg_setup() {
	enewgroup grafana
	enewuser grafana -1 -1 /usr/share/grafana grafana
}

src_install() {

	# Frontend assets
	insinto /usr/share/${MY_PN}
	doins -r public conf vendor

	dobin bin/grafana-server

	newconfd "${FILESDIR}"/grafana.confd grafana
	newinitd "${FILESDIR}"/grafana.initd grafana

	keepdir /etc/grafana
	insinto /etc/grafana
	doins "${FILESDIR}"/grafana.ini

	keepdir /var/{lib,log}/grafana
	fowners grafana:grafana /var/{lib,log}/grafana
	fperms 0750 /var/{lib,log}/grafana
}
