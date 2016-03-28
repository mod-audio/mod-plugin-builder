######################################
#
# tap-lv2
#
######################################

TAP_LV2_VERSION = de26a3c8c8c2227e6d7fba3dcb54ec5fe2def258
TAP_LV2_SITE = $(call github,moddevices,tap-lv2,$(TAP_LV2_VERSION))
TAP_LV2_BUNDLES = tap-autopan.lv2 tap-chorusflanger.lv2 tap-deesser.lv2 tap-doubler.lv2 tap-dynamics.lv2 tap-dynamics-st.lv2 tap-echo.lv2 tap-eqbw.lv2 tap-eq.lv2 tap-limiter.lv2 tap-pinknoise.lv2 tap-pitch.lv2 tap-reflector.lv2 tap-reverb.lv2 tap-rotspeak.lv2 tap-sigmoid.lv2 tap-tremolo.lv2 tap-tubewarmth.lv2 tap-vibrato.lv2

TAP_LV2_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) NOOPT=true -C $(@D)

define TAP_LV2_BUILD_CMDS
	$(TAP_LV2_TARGET_MAKE)
endef

define TAP_LV2_INSTALL_TARGET_CMDS
	$(TAP_LV2_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_PATH=/usr/lib/lv2
endef

$(eval $(generic-package))
