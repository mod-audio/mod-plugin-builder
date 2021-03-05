######################################
#
# carla-plugins-labs
#
######################################

CARLA_PLUGINS_LABS_VERSION = a39fc148d4a922c6e9703a9b76248318b84a9996
CARLA_PLUGINS_LABS_SITE = $(call github,falkTX,Carla,$(CARLA_PLUGINS_LABS_VERSION))
CARLA_PLUGINS_LABS_DEPENDENCIES = libsndfile
CARLA_PLUGINS_LABS_BUNDLES = carla-audiogain.lv2 carla-files.lv2 carla-miditools.lv2

CARLA_PLUGINS_LABS_NO_GUI = HAVE_FFMPEG=false HAVE_HYLIA=false HAVE_PYQT=false

CARLA_PLUGINS_LABS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) $(CARLA_PLUGINS_LABS_NO_GUI) NOOPT=true -C $(@D) lv2-bundles

define CARLA_PLUGINS_LABS_BUILD_CMDS
	$(CARLA_PLUGINS_LABS_TARGET_MAKE)
endef

define CARLA_PLUGINS_LABS_INSTALL_TARGET_CMDS
	install -d $(TARGET_DIR)/usr/lib/lv2/
	cp -rL $(@D)/bin/carla-*.lv2 $(TARGET_DIR)/usr/lib/lv2/
	cp -rL $($(PKG)_PKGDIR)/carla-audiogain.lv2/* $(TARGET_DIR)/usr/lib/lv2/carla-audiogain.lv2/
	cp -rL $($(PKG)_PKGDIR)/carla-files.lv2/* $(TARGET_DIR)/usr/lib/lv2/carla-files.lv2/
endef

$(eval $(generic-package))
