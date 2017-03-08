######################################
#
# pdlv2
#
######################################

PDLV2_VERSION = 5951a0f0cd7b5d2bb2bc8c1cb9785df969a36d4b
PDLV2_SITE = $(call github,x37v,pdlv2,$(PDLV2_VERSION))
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
