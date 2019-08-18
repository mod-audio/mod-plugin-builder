######################################
#
# carla
#
######################################

CARLA_VERSION = 8385b5ee418357e2dc907518ac39c20beb3b28ed
CARLA_SITE = $(call github,falkTX,Carla,$(CARLA_VERSION))
CARLA_DEPENDENCIES = libsndfile
# FIXME ffmpeg fluidsynth as dependencies, plus liblo eventually
CARLA_BUNDLES = carla.lv2

CARLA_NO_DEPS = HAVE_FFMPEG=false HAVE_FLUIDSYNTH=false HAVE_LIBLO=false
CARLA_NO_GUI  = HAVE_HYLIA=false HAVE_PYQT=false

CARLA_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) $(CARLA_NO_DEPS) $(CARLA_NO_GUI) NOOPT=true -C $(@D)

define CARLA_BUILD_CMDS
	$(CARLA_TARGET_MAKE)
endef

define CARLA_INSTALL_TARGET_CMDS
	$(CARLA_TARGET_MAKE) install DESTDIR=$(TARGET_DIR)
	# cp -rL $($(PKG)_PKGDIR)/carla.lv2/* $(TARGET_DIR)/usr/lib/lv2/carla.lv2/
endef

$(eval $(generic-package))
