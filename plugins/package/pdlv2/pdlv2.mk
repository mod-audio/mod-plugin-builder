######################################
#
# pdlv2
#
######################################

PDLV2_VERSION = f8b8de956f649e481424b28cec9ca78174b21631
PDLV2_SITE = $(call github,moddevices,pdlv2,$(PDLV2_VERSION))
PDLV2_DEPENDENCIES = libpd lvtk
PDLV2_BUNDLES = pdlv2-autopan.lv2 pdlv2-demo_distortion.lv2 pdlv2-demo_sine_synth.lv2 pdlv2-djfilter.lv2 pdlv2-midi_demo.lv2

PDLV2_LVTK=$(STAGING_DIR)/usr/lib/liblvtk_plugin2.a
PDLV2_LIBPD=$(STAGING_DIR)/usr/lib/libpd.so

PDLV2_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) LVTKLIB=$(PDLV2_LVTK) LIBPD_SO=$(PDLV2_LIBPD) RUBY=/usr/bin/ruby -C $(@D)

define PDLV2_BUILD_CMDS
	(cd $(@D) && /usr/bin/bundle install)
	(cd $(@D) && [ -d lvtk ] && [ ! -L lvtk ] && rmdir lvtk && ln -s $(STAGING_DIR)/usr/include/lvtk-2 lvtk || true)
	$(PDLV2_TARGET_MAKE)
endef

define PDLV2_INSTALL_TARGET_CMDS
	$(PDLV2_TARGET_MAKE) install INSTALL_DIR=$(TARGET_DIR)/usr/lib/lv2
endef

$(eval $(generic-package))
