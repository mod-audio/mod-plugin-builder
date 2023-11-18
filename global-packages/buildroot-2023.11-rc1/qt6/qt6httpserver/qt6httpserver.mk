################################################################################
#
# qt6httpserver
#
################################################################################

QT6HTTPSERVER_VERSION = $(QT6_VERSION)
QT6HTTPSERVER_SITE = $(QT6_SITE)
QT6HTTPSERVER_SOURCE = qthttpserver-$(QT6_SOURCE_TARBALL_PREFIX)-$(QT6HTTPSERVER_VERSION).tar.xz
QT6HTTPSERVER_INSTALL_STAGING = YES
QT6HTTPSERVER_SUPPORTS_IN_SOURCE_BUILD = NO

QT6HTTPSERVER_CMAKE_BACKEND = ninja

QT6HTTPSERVER_CONF_OPTS = \
	-DQT_HOST_PATH=$(HOST_DIR) \
	-DBUILD_WITH_PCH=OFF \
	-DQT_BUILD_EXAMPLES=OFF \
	-DQT_BUILD_TESTS=OFF

QT6HTTPSERVER_DEPENDENCIES = \
	host-pkgconf \
	qt6websockets

$(eval $(cmake-package))
