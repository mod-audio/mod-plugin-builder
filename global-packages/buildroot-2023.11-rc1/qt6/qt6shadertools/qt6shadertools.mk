################################################################################
#
# qt6shadertools
#
################################################################################

QT6SHADERTOOLS_VERSION = $(QT6_VERSION)
QT6SHADERTOOLS_SITE = $(QT6_SITE)
QT6SHADERTOOLS_SOURCE = qtshadertools-$(QT6_SOURCE_TARBALL_PREFIX)-$(QT6SHADERTOOLS_VERSION).tar.xz
QT6SHADERTOOLS_INSTALL_STAGING = YES
QT6SHADERTOOLS_SUPPORTS_IN_SOURCE_BUILD = NO

QT6SHADERTOOLS_CMAKE_BACKEND = ninja

QT6SHADERTOOLS_CONF_OPTS = \
	-DQT_HOST_PATH=$(HOST_DIR) \
	-DBUILD_WITH_PCH=OFF \
	-DQT_BUILD_EXAMPLES=OFF \
	-DQT_BUILD_TESTS=OFF

QT6SHADERTOOLS_DEPENDENCIES = \
	host-pkgconf \
	host-qt6base \
	host-qt6shadertools \
	qt6base

$(eval $(cmake-package))
$(eval $(host-cmake-package))
