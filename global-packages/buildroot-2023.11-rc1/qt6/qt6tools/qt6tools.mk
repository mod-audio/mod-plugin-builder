################################################################################
#
# qt6tools
#
################################################################################

QT6TOOLS_VERSION = $(QT6_VERSION)
QT6TOOLS_SITE = $(QT6_SITE)
QT6TOOLS_SOURCE = qttools-$(QT6_SOURCE_TARBALL_PREFIX)-$(QT6TOOLS_VERSION).tar.xz
QT6TOOLS_INSTALL_STAGING = YES
QT6TOOLS_SUPPORTS_IN_SOURCE_BUILD = NO

QT6TOOLS_CMAKE_BACKEND = ninja

QT6TOOLS_CONF_OPTS = \
	-DQT_HOST_PATH=$(HOST_DIR) \
	-DBUILD_WITH_PCH=OFF \
	-DQT_BUILD_EXAMPLES=OFF \
	-DQT_BUILD_TESTS=OFF

QT6TOOLS_CONF_OPTS += -DFEATURE_clang=OFF
QT6TOOLS_CONF_OPTS += -DFEATURE_designer=OFF -DFEATURE_linguist=OFF
HOST_QT6TOOLS_CONF_OPTS = -DFEATURE_designer=ON -DFEATURE_linguist=ON

QT6TOOLS_DEPENDENCIES = \
	host-pkgconf \
	host-qt6tools \
	qt6declarative

$(eval $(cmake-package))
$(eval $(host-cmake-package))
