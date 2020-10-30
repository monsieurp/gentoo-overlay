# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )

inherit autotools java-pkg-opt-2 python-single-r1 toolchain-funcs user

DESCRIPTION="Apache Mesos is computer cluster manager"
HOMEPAGE="https://mesos.apache.org"
SRC_URI="mirror://apache/${PN}/${PV}/${P}.tar.gz"
IUSE="master agent"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=virtual/jre-1.8"

DEPEND="
	${RDEPEND}
	>=virtual/jdk-1.8
	dev-java/maven-bin:3.6
	dev-java/openjdk-bin
	dev-libs/cyrus-sasl
	dev-vcs/subversion
	dev-python/six
	net-misc/curl
	sys-libs/zlib
	dev-libs/apr"

RDEPEND="${PYTHON_DEPS}"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DOCS=( LICENSE README.md NOTICE )

RESTRICT="test"

REQUIRED_USE="^^ ( master agent )"

pkg_setup() {
	python-single-r1_pkg_setup
	java-pkg-opt-2_pkg_setup

	# The user account "warden" is used across all Mesos/Spark/Chronos services
	# to keep the whole user account management consistent across the cluster
	# and to avoid running into user permission errors.
	enewgroup warden
	enewuser warden -1 -1 /var/lib/warden warden
}

src_prepare() {
	default

	eautoreconf
}

src_compile() {
	# just so that these variables are set up throughout the whole process.
	export CC="$(tc-getCC)" CXX="$(tc-getCXX)"

	# make will fail on:
	# src/core/lib/gpr/log_linux.cc:42:13: error: ambiguating new declaration
	# of ‘long int gettid()’
	make -j4

	# fix this problem.
	eapply "${FILESDIR}/${P}-gettid-log_linux.cc.patch"
	# useless parens causing a build failure. remove them.
	eapply "${FILESDIR}/${P}-boost-assert.hpp.patch"

	# let's restart the compilation process.
	emake
}

src_install() {
	emake DESTDIR="${D}" install

	# suppress a QA warning wrt non-compiled pyo.
	# compile those files.
	python_optimize

	# Install Mesos initd and confd files.
	if use master; then
		newinitd "${FILESDIR}/mesos-master.initd" "mesos-master"
		newconfd "${FILESDIR}/mesos-master.confd" "mesos-master"
	fi
	if use agent; then
		newinitd "${FILESDIR}/mesos-agent.initd" "mesos-agent"
		newconfd "${FILESDIR}/mesos-agent.confd" "mesos-agent"
	fi

	local x
	for x in /var/{lib,log}/warden; do
		keepdir "${x}"
		fowners warden:warden "${x}"
	done

	einstalldocs
}