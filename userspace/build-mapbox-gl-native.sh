# Contributor: Bart Ribbers <bribbers@disroot.org>
# Contributor: Cameron Clough <cameronjclough@gmail.com>
# Maintainer: Cameron Clough <cameronjclough@gmail.com>
pkgname=mapbox-gl-native
pkgver=1.6.1
pkgrel=0
pkgdesc="Mapbox GL Native"
url="https://github.com/incognitojam/mapbox-gl-native"
arch="all"
license="BSD-2-Clause"
makedepends="
	cmake
	icu-dev
	qt5-qtbase-dev
	rapidjson-dev
	"
source="
	mapbox-gl-native-$pkgver.tar.gz::https://github.com/incognitojam/mapbox-gl-native/archive/v$pkgver.tar.gz
	0001-skip-license-check.patch::https://git.alpinelinux.org/aports/plain/community/mapbox-gl-native/0002-skip-license-check.patch
	"
options="!check" # No tests
subpackages=""
builddir="$srcdir/$pkgname"

prepare() {
	default_prepare

	# We prefer to build with our system version
	rm -r vendor/mapbox-base/extras/rapidjson
}

build() {
	cmake -B build \
		-DCMAKE_BUILD_TYPE=None \
		-DCMAKE_INSTALL_PREFIX=/usr \
		-DCMAKE_INSTALL_LIBDIR=lib \
		-DBUILD_SHARED_LIBS=TRUE \
		-DMBGL_WITH_WERROR=OFF \
		-DMBGL_WITH_QT=ON \
		-DMBGL_WITH_QT_LIB_ONLY=ON \
		-DMBGL_WITH_QT_HEADLESS=OFF
	cmake --build build
}

package() {
	DESTDIR="$pkgdir" cmake --install build
}

sha512sums="5e70f04fc22854f2208c335e12bd85252432d7939a1b205c5dbaebe27a3de681cd14e2ef88100f04bc4c84b412020670681f2d548e7cdc209ee3aaa70349f025  mapbox-gl-native-1.6.0.tar.gz
609d2eea6199c0e1c5f63fc950a8a0155e88987738d9ae038fd8f23eef01738b381365388cad22de8638fb2d2d68bea224cc8d4855a5cdca21a85575e09b22e6  0001-skip-license-check.patch
