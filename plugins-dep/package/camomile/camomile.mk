######################################
#
# camomile
#
######################################

CAMOMILE_VERSION = 713be25fe02676dda825e33ef4566b1c458daf4f
CAMOMILE_SITE = $(call github,DISTRHO,DISTRHO-Ports,$(CAMOMILE_VERSION))

CAMOMILE_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) LINUX_EMBED=1 -C $(@D)

CAMOMILE_SO_GEN  = $(TARGET_DIR)/usr/bin/camomile_lv2_gen
CAMOMILE_SO_FILE = $(TARGET_DIR)/usr/lib/Camomile.so

define CAMOMILE_CONFIGURE_CMDS
       (cd $(@D); LINUX_EMBED=1 ./scripts/premake-update.sh linux)
endef

define CAMOMILE_BUILD_CMDS
	$(CAMOMILE_TARGET_MAKE) -C $(@D)/libs/juce
	$(CAMOMILE_TARGET_MAKE) -C $(@D)/libs/lv2-ttl-generator
	$(CAMOMILE_TARGET_MAKE) -C $(@D)/ports/camomile/LV2
endef

define CAMOMILE_INSTALL_TARGET_CMDS
	install -d $(TARGET_DIR)/usr/bin
	install -d $(TARGET_DIR)/usr/lib
	install -m 755 $(@D)/libs/lv2_ttl_generator $(CAMOMILE_SO_GEN)
	install -m 644 $(@D)/bin/lv2/Camomile.lv2/Camomile.so $(CAMOMILE_SO_FILE)
endef

$(eval $(generic-package))
