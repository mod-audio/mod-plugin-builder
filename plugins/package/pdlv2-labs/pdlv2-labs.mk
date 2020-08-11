######################################
#
# pdlv2-labs
#
######################################

PDLV2_LABS_VERSION = 5951a0f0cd7b5d2bb2bc8c1cb9785df969a36d4b
PDLV2_LABS_SITE = $(call github,x37v,pdlv2,$(PDLV2_LABS_VERSION))
PDLV2_LABS_DEPENDENCIES = libpd lvtk
PDLV2_LABS_BUNDLES = pdlv2-autopan.lv2 pdlv2-demo_distortion.lv2 pdlv2-demo_sine_synth.lv2 pdlv2-djfilter.lv2 pdlv2-midi_demo.lv2

PDLV2_LABS_LVTK=$(STAGING_DIR)/usr/lib/liblvtk_plugin2.a
PDLV2_LABS_LIBPD=$(STAGING_DIR)/usr/lib/libpd.so

PDLV2_LABS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) LVTKLIB=$(PDLV2_LABS_LVTK) LIBPD_SO=$(PDLV2_LABS_LIBPD) RUBY=/usr/bin/ruby -C $(@D)

define PDLV2_LABS_BUILD_CMDS
	(cd $(@D) && /usr/bin/bundle install)
	(cd $(@D) && [ -d lvtk ] && [ ! -L lvtk ] && rmdir lvtk && ln -s $(STAGING_DIR)/usr/include/lvtk-2 lvtk || true)
	$(PDLV2_LABS_TARGET_MAKE)
endef

define PDLV2_LABS_INSTALL_TARGET_CMDS
	$(PDLV2_LABS_TARGET_MAKE) install INSTALL_DIR=$(TARGET_DIR)/usr/lib/lv2
endef

$(eval $(generic-package))
