######################################
#
# carla-plugins
#
######################################

CARLA_PLUGINS_VERSION = a627caf17f141009602a76e99cbfc93f5b7d1455
CARLA_PLUGINS_SITE = $(call github,falkTX,Carla,$(CARLA_PLUGINS_VERSION))
CARLA_PLUGINS_DEPENDENCIES = libsndfile
CARLA_PLUGINS_BUNDLES = carla-files.lv2

CARLA_PLUGINS_NO_GUI = HAVE_FFMPEG=false HAVE_HYLIA=false HAVE_PYQT=false

CARLA_PLUGINS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) $(CARLA_PLUGINS_NO_GUI) NOOPT=true -C $(@D) lv2-bundles

ifeq ($(BR2_OPTIMIZE_0),y)
CARLA_PLUGINS_TARGET_MAKE += DEBUG=true
endif

define CARLA_PLUGINS_BUILD_CMDS
	$(CARLA_PLUGINS_TARGET_MAKE)
endef

define CARLA_PLUGINS_INSTALL_TARGET_CMDS
	install -d $(TARGET_DIR)/usr/lib/lv2/
	cp -rL $(@D)/bin/carla-*.lv2 $(TARGET_DIR)/usr/lib/lv2/
	cp -rL $($(PKG)_PKGDIR)/carla-files.lv2/* $(TARGET_DIR)/usr/lib/lv2/carla-files.lv2/
endef

$(eval $(generic-package))
