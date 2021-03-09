######################################
#
# carla-plugins
#
######################################

CARLA_PLUGINS_VERSION = 838df7eac598d14885a1ed3eff7a0ddd6ceb8927
CARLA_PLUGINS_SITE = $(call github,falkTX,Carla,$(CARLA_PLUGINS_VERSION))
CARLA_PLUGINS_DEPENDENCIES = libsndfile
CARLA_PLUGINS_BUNDLES = carla-files.lv2

CARLA_PLUGINS_NO_GUI = HAVE_FFMPEG=false HAVE_HYLIA=false HAVE_PYQT=false

CARLA_PLUGINS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) $(CARLA_PLUGINS_NO_GUI) NOOPT=true -C $(@D) lv2-bundles

define CARLA_PLUGINS_BUILD_CMDS
	$(CARLA_PLUGINS_TARGET_MAKE)
endef

define CARLA_PLUGINS_INSTALL_TARGET_CMDS
	install -d $(TARGET_DIR)/usr/lib/lv2/
	cp -rL $(@D)/bin/carla-*.lv2 $(TARGET_DIR)/usr/lib/lv2/
	cp -rL $($(PKG)_PKGDIR)/carla-files.lv2/* $(TARGET_DIR)/usr/lib/lv2/carla-files.lv2/
endef

$(eval $(generic-package))
