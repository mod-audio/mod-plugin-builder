######################################
#
# distrho-ports-labs
#
######################################

DISTRHO_PORTS_LABS_VERSION = 65c7c68a79e532d01695466f5b94c0e1cc4ae940
DISTRHO_PORTS_LABS_SITE = $(call github,moddevices,DISTRHO-Ports,$(DISTRHO_PORTS_LABS_VERSION))
DISTRHO_PORTS_LABS_BUNDLES = drowaudio-distortion.lv2 drowaudio-distortionshaper.lv2 drowaudio-flanger.lv2 drowaudio-reverb.lv2 drowaudio-tremolo.lv2 Luftikus.lv2 Obxd.lv2 TAL-Dub-3.lv2 TAL-Filter-2.lv2 TAL-Filter.lv2 TAL-NoiseMaker.lv2 TAL-Reverb-2.lv2 TAL-Reverb-3.lv2 TAL-Reverb.lv2 TAL-Vocoder-2.lv2 TheFunction.lv2 ThePilgrim.lv2 Temper.lv2 Vex.lv2 Wolpertinger.lv2

DISTRHO_PORTS_LABS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) LINUX_EMBED=true -C $(@D)

define DISTRHO_PORTS_LABS_CONFIGURE_CMDS
       (cd $(@D); LINUX_EMBED=1 ./scripts/premake-update.sh linux)
endef

define DISTRHO_PORTS_LABS_BUILD_CMDS
	$(DISTRHO_PORTS_LABS_TARGET_MAKE) lv2_nogen
endef

define DISTRHO_PORTS_LABS_INSTALL_TARGET_CMDS
	install -d $(TARGET_DIR)/usr/lib/lv2/
	cp -r $(@D)/bin/lv2/*.lv2/    $(TARGET_DIR)/usr/lib/lv2/
	cp -rL $($(PKG)_PKGDIR)/*.lv2 $(TARGET_DIR)/usr/lib/lv2/
endef

$(eval $(generic-package))
