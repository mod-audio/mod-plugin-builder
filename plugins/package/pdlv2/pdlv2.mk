######################################
#
# pdlv2
#
######################################

PDLV2_VERSION = 408f111dfa1f50c6f3f0499f1c15a40264573edf
PDLV2_SITE = $(call github,x37v,pdlv2,$(PDLV2_VERSION))
PDLV2_DEPENDENCIES = libpd lvtk
# host-ruby
PDLV2_BUNDLES = xxx.lv2

PDLV2_LVTK=$(STAGING_DIR)/usr/lib/liblvtk_plugin2.a
PDLV2_LIBPD=$(STAGING_DIR)/usr/lib/libpd.so

PDLV2_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) LVTKLIB=$(PDLV2_LVTK) LIBPD_SO=$(PDLV2_LIBPD) -C $(@D)

define PDLV2_BUILD_CMDS
# 	bundle install
	$(PDLV2_TARGET_MAKE)
endef

define PDLV2_INSTALL_TARGET_CMDS
	$(PDLV2_TARGET_MAKE) install INSTALL_DIR=$(TARGET_DIR)/usr/lib/lv2
endef

$(eval $(generic-package))
