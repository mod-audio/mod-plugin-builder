######################################
#
# distrho-ports
#
######################################

DISTRHO_PORTS_VERSION = f591a1066cd3929536699bb516caa4b5efd9d025
DISTRHO_PORTS_SITE = $(call github,DISTRHO,DISTRHO-Ports,$(DISTRHO_PORTS_VERSION))
DISTRHO_PORTS_BUNDLES = drowaudio-distortion.lv2 drowaudio-distortionshaper.lv2 drowaudio-flanger.lv2 drowaudio-reverb.lv2 drowaudio-tremolo.lv2 Luftikus.lv2 Obxd.lv2 TAL-Dub-3.lv2 TAL-Filter-2.lv2 TAL-Filter.lv2 TAL-NoiseMaker.lv2 TAL-Reverb-2.lv2 TAL-Reverb-3.lv2 TAL-Reverb.lv2 TAL-Vocoder-2.lv2 TheFunction.lv2 ThePilgrim.lv2 Vex.lv2 Wolpertinger.lv2

DISTRHO_PORTS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) LINUX_EMBED=true -C $(@D)

define DISTRHO_PORTS_CONFIGURE_CMDS
       (cd $(@D); LINUX_EMBED=1 ./scripts/premake-update.sh linux)
endef

define DISTRHO_PORTS_BUILD_CMDS
	$(DISTRHO_PORTS_TARGET_MAKE) lv2_nogen
endef

define DISTRHO_PORTS_INSTALL_TARGET_CMDS
	install -d $(TARGET_DIR)/usr/lib/lv2/
	cp -r $(@D)/bin/lv2/*.lv2/    $(TARGET_DIR)/usr/lib/lv2/
	cp -rL $($(PKG)_PKGDIR)/*.lv2 $(TARGET_DIR)/usr/lib/lv2/
endef

$(eval $(generic-package))
