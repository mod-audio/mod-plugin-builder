DISTRHO_PORTS_VERSION = 82524089a53a9f3ac10a95fabcae2ae61cc5137f
DISTRHO_PORTS_SITE = $(call github,DISTRHO,DISTRHO-Ports,$(DISTRHO_PORTS_VERSION))
DISTRHO_PORTS_DEPENDENCIES = alsa-lib xlib_libX11 xlib_libXcursor xlib_libXext
DISTRHO_PORTS_BUNDLES = 

DISTRHO_PORTS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE)

define DISTRHO_PORTS_CONFIGURE_CMDS
#        (cd $(@D); NOOPTIMIZATIONS=1 ./scripts/premake-update.sh linux)
	sed -i "s/JUCE_PLUGINHOST_LADSPA 1/JUCE_PLUGINHOST_LADSPA 0/" $(@D)/libs/juce/build-juce/AppConfig.h
	sed -i "s/JUCE_PLUGINHOST_VST 1/JUCE_PLUGINHOST_VST 0/" $(@D)/libs/juce/build-juce/AppConfig.h
endef

define DISTRHO_PORTS_BUILD_CMDS
	$(DISTRHO_PORTS_TARGET_MAKE) -C $(@D)/libs/juce
	$(DISTRHO_PORTS_TARGET_MAKE) -C $(@D)/ports/tal-noisemaker/LV2/
endef

define DISTRHO_PORTS_INSTALL_TARGET_CMDS
	install -d $(TARGET_DIR)/usr/lib/lv2/
	cp -r $(@D)/bin/lv2/*.lv2/        $(TARGET_DIR)/usr/lib/lv2/
	cp -r $(@D)/static-lv2-ttl/*.lv2/ $(TARGET_DIR)/usr/lib/lv2/
endef

$(eval $(generic-package))
