######################################
#
# carla
#
######################################

CARLA_VERSION = 08e416113bcb0facaac952370fdee19937907384
CARLA_SITE = $(call github,falkTX,Carla,$(CARLA_VERSION))
CARLA_DEPENDENCIES = libsndfile ffmpeg
# for later: fluidsynth liblo (unused at the moment)
CARLA_BUNDLES = carla-audiogain.lv2 carla-files.lv2 carla-miditools.lv2

CARLA_NO_GUI = HAVE_HYLIA=false HAVE_PYQT=false

CARLA_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) $(CARLA_NO_GUI) NOOPT=true -C $(@D) lv2-bundles

define CARLA_BUILD_CMDS
	$(CARLA_TARGET_MAKE)
endef

define CARLA_INSTALL_TARGET_CMDS
	install -d $(TARGET_DIR)/usr/lib/lv2/
	cp -rL $(@D)/bin/carla-*.lv2 $(TARGET_DIR)/usr/lib/lv2/
	cp -rL $($(PKG)_PKGDIR)/carla-audiogain.lv2/* $(TARGET_DIR)/usr/lib/lv2/carla-audiogain.lv2/
endef

$(eval $(generic-package))
