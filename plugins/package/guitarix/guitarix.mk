######################################
#
# guitarix
#
######################################

GUITARIX_VERSION = 589dd79b2d7ad2b5e0db4c18c25279d6e94a1552
GUITARIX_SITE = $(call github,moddevices,guitarix,$(GUITARIX_VERSION))
GUITARIX_DEPENDENCIES = boost eigen fftw-single glibmm libsndfile zita-convolver zita-resampler host-python host-intltool
GUITARIX_BUNDLES = gx_amp.lv2 gx_amp_stereo.lv2 gx_cabinet.lv2 gx_colwah.lv2 gx_compressor.lv2 gx_cstb.lv2 gx_delay.lv2 gx_detune.lv2 gx_digital_delay.lv2 gx_digital_delay_st.lv2 gx_duck_delay.lv2 gx_duck_delay_st.lv2 gx_echo.lv2 gx_expander.lv2 gx_flanger.lv2 gx_fumaster.lv2 gx_fuzz.lv2 gx_fuzzface.lv2 gx_fuzzfacefm.lv2 gx_gcb_95.lv2 gx_hfb.lv2 gx_hogsfoot.lv2 gx_hornet.lv2 gx_jcm800pre.lv2 gx_jcm800pre_st.lv2 gx_mbdelay.lv2 gx_mole.lv2 gx_muff.lv2 gx_oc_2.lv2 gx_phaser.lv2 gx_rangem.lv2 gx_redeye.lv2 gx_reverb.lv2 gx_room_simulator.lv2 gx_scream.lv2 gx_shimmizita.lv2 gx_susta.lv2 gx_switched_tremolo.lv2 gxbooster.lv2 gxtilttone.lv2 gxts9.lv2 gxwah.lv2


GUITARIX_TARGET_WAF = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) EIGEN3_PATH=$(STAGING_DIR)/usr/include/eigen3/ $(HOST_DIR)/usr/bin/python2 ./waf

define GUITARIX_CONFIGURE_CMDS
	(cd $(@D)/trunk; $(GUITARIX_TARGET_WAF) configure --prefix=/usr --disable-sse --lv2-only --no-lv2-gui --no-faust)
endef

define GUITARIX_BUILD_CMDS
	(cd $(@D)/trunk; $(GUITARIX_TARGET_WAF) build -j $(PARALLEL_JOBS))
endef

define GUITARIX_INSTALL_TARGET_CMDS
	(cd $(@D)/trunk; $(GUITARIX_TARGET_WAF) install --destdir=$(TARGET_DIR))
	cp -rL $($(PKG)_PKGDIR)/gx_amp.lv2/*                 $(TARGET_DIR)/usr/lib/lv2/gx_amp.lv2/
	cp -rL $($(PKG)_PKGDIR)/gx_amp_stereo.lv2/*          $(TARGET_DIR)/usr/lib/lv2/gx_amp_stereo.lv2/
	cp -rL $($(PKG)_PKGDIR)/gx_cabinet.lv2/*             $(TARGET_DIR)/usr/lib/lv2/gx_cabinet.lv2/
	cp -rL $($(PKG)_PKGDIR)/gx_colwah.lv2/*              $(TARGET_DIR)/usr/lib/lv2/gx_colwah.lv2/
	cp -rL $($(PKG)_PKGDIR)/gx_compressor.lv2/*          $(TARGET_DIR)/usr/lib/lv2/gx_compressor.lv2/
	cp -rL $($(PKG)_PKGDIR)/gx_cstb.lv2/*                $(TARGET_DIR)/usr/lib/lv2/gx_cstb.lv2/
	cp -rL $($(PKG)_PKGDIR)/gx_delay.lv2/*               $(TARGET_DIR)/usr/lib/lv2/gx_delay.lv2/
	cp -rL $($(PKG)_PKGDIR)/gx_detune.lv2/*              $(TARGET_DIR)/usr/lib/lv2/gx_detune.lv2/
	cp -rL $($(PKG)_PKGDIR)/gx_digital_delay.lv2/*       $(TARGET_DIR)/usr/lib/lv2/gx_digital_delay.lv2/
	cp -rL $($(PKG)_PKGDIR)/gx_digital_delay_st.lv2/*    $(TARGET_DIR)/usr/lib/lv2/gx_digital_delay_st.lv2/
	cp -rL $($(PKG)_PKGDIR)/gx_duck_delay.lv2/*          $(TARGET_DIR)/usr/lib/lv2/gx_duck_delay.lv2/
	cp -rL $($(PKG)_PKGDIR)/gx_duck_delay_st.lv2/*       $(TARGET_DIR)/usr/lib/lv2/gx_duck_delay_st.lv2/
	cp -rL $($(PKG)_PKGDIR)/gx_echo.lv2/*                $(TARGET_DIR)/usr/lib/lv2/gx_echo.lv2/
	cp -rL $($(PKG)_PKGDIR)/gx_expander.lv2/*            $(TARGET_DIR)/usr/lib/lv2/gx_expander.lv2/
	cp -rL $($(PKG)_PKGDIR)/gx_flanger.lv2/*             $(TARGET_DIR)/usr/lib/lv2/gx_flanger.lv2/
	cp -rL $($(PKG)_PKGDIR)/gx_fumaster.lv2/*            $(TARGET_DIR)/usr/lib/lv2/gx_fumaster.lv2/
	cp -rL $($(PKG)_PKGDIR)/gx_fuzz.lv2/*                $(TARGET_DIR)/usr/lib/lv2/gx_fuzz.lv2/
	cp -rL $($(PKG)_PKGDIR)/gx_fuzzface.lv2/*            $(TARGET_DIR)/usr/lib/lv2/gx_fuzzface.lv2/
	cp -rL $($(PKG)_PKGDIR)/gx_fuzzfacefm.lv2/*          $(TARGET_DIR)/usr/lib/lv2/gx_fuzzfacefm.lv2/
	cp -rL $($(PKG)_PKGDIR)/gx_gcb_95.lv2/*              $(TARGET_DIR)/usr/lib/lv2/gx_gcb_95.lv2/
	cp -rL $($(PKG)_PKGDIR)/gx_hfb.lv2/*                 $(TARGET_DIR)/usr/lib/lv2/gx_hfb.lv2/
	cp -rL $($(PKG)_PKGDIR)/gx_hogsfoot.lv2/*            $(TARGET_DIR)/usr/lib/lv2/gx_hogsfoot.lv2/
	cp -rL $($(PKG)_PKGDIR)/gx_hornet.lv2/*              $(TARGET_DIR)/usr/lib/lv2/gx_hornet.lv2/
	cp -rL $($(PKG)_PKGDIR)/gx_jcm800pre.lv2/*           $(TARGET_DIR)/usr/lib/lv2/gx_jcm800pre.lv2/
	cp -rL $($(PKG)_PKGDIR)/gx_jcm800pre_st.lv2/*        $(TARGET_DIR)/usr/lib/lv2/gx_jcm800pre_st.lv2/
	cp -rL $($(PKG)_PKGDIR)/gx_mbdelay.lv2/*             $(TARGET_DIR)/usr/lib/lv2/gx_mbdelay.lv2/
	cp -rL $($(PKG)_PKGDIR)/gx_mole.lv2/*                $(TARGET_DIR)/usr/lib/lv2/gx_mole.lv2/
	cp -rL $($(PKG)_PKGDIR)/gx_muff.lv2/*                $(TARGET_DIR)/usr/lib/lv2/gx_muff.lv2/
	cp -rL $($(PKG)_PKGDIR)/gx_oc_2.lv2/*                $(TARGET_DIR)/usr/lib/lv2/gx_oc_2.lv2/
	cp -rL $($(PKG)_PKGDIR)/gx_phaser.lv2/*              $(TARGET_DIR)/usr/lib/lv2/gx_phaser.lv2/
	cp -rL $($(PKG)_PKGDIR)/gx_rangem.lv2/*              $(TARGET_DIR)/usr/lib/lv2/gx_rangem.lv2/
	cp -rL $($(PKG)_PKGDIR)/gx_redeye.lv2/*              $(TARGET_DIR)/usr/lib/lv2/gx_redeye.lv2/
	cp -rL $($(PKG)_PKGDIR)/gx_reverb.lv2/*              $(TARGET_DIR)/usr/lib/lv2/gx_reverb.lv2/
	cp -rL $($(PKG)_PKGDIR)/gx_room_simulator.lv2/*      $(TARGET_DIR)/usr/lib/lv2/gx_room_simulator.lv2/
	cp -rL $($(PKG)_PKGDIR)/gx_scream.lv2/*              $(TARGET_DIR)/usr/lib/lv2/gx_scream.lv2/
	cp -rL $($(PKG)_PKGDIR)/gx_shimmizita.lv2/*          $(TARGET_DIR)/usr/lib/lv2/gx_shimmizita.lv2/
	cp -rL $($(PKG)_PKGDIR)/gx_studiopre.lv2/*           $(TARGET_DIR)/usr/lib/lv2/gx_studiopre.lv2/
	cp -rL $($(PKG)_PKGDIR)/gx_studiopre_st.lv2/*        $(TARGET_DIR)/usr/lib/lv2/gx_studiopre_st.lv2/
	cp -rL $($(PKG)_PKGDIR)/gx_susta.lv2/*               $(TARGET_DIR)/usr/lib/lv2/gx_susta.lv2/
	cp -rL $($(PKG)_PKGDIR)/gx_switched_tremolo.lv2/*    $(TARGET_DIR)/usr/lib/lv2/gx_switched_tremolo.lv2/
	cp -rL $($(PKG)_PKGDIR)/gxbooster.lv2/*              $(TARGET_DIR)/usr/lib/lv2/gxbooster.lv2/
	cp -rL $($(PKG)_PKGDIR)/gxtilttone.lv2/*             $(TARGET_DIR)/usr/lib/lv2/gxtilttone.lv2/
	cp -rL $($(PKG)_PKGDIR)/gxts9.lv2/*                  $(TARGET_DIR)/usr/lib/lv2/gxts9.lv2/

	# gxautowah.lv2 has been manually splitted into separate bundles
	mv $(TARGET_DIR)/usr/lib/lv2/gxautowah.lv2/gxautowah.so $(TARGET_DIR)/usr/lib/lv2/gxautowah.so
	rm -rf $(TARGET_DIR)/usr/lib/lv2/gxautowah.lv2/
	cp -rL $($(PKG)_PKGDIR)/gxwah.lv2     $(TARGET_DIR)/usr/lib/lv2/
	cp $(TARGET_DIR)/usr/lib/lv2/gxautowah.so $(TARGET_DIR)/usr/lib/lv2/gxwah.lv2/
	rm $(TARGET_DIR)/usr/lib/lv2/gxautowah.so

	# broken plugins
	rm -rf $(TARGET_DIR)/usr/lib/lv2/gx_vibe.lv2/
endef

$(eval $(generic-package))
