######################################
#
# mod-mda-lv2
#
######################################

MOD_MDA_LV2_VERSION = 3d6dd099146b72c1fe88e06679034715fb999a5b
MOD_MDA_LV2_SITE = $(call github,moddevices,mda-lv2,$(MOD_MDA_LV2_VERSION))
MOD_MDA_LV2_BUNDLES = mod-mda-Ambience.lv2 mod-mda-Bandisto.lv2 mod-mda-BeatBox.lv2 mod-mda-Combo.lv2 mod-mda-DeEss.lv2 mod-mda-Degrade.lv2 mod-mda-Delay.lv2 mod-mda-Detune.lv2 mod-mda-Dither.lv2 mod-mda-DubDelay.lv2 mod-mda-DX10.lv2 mod-mda-Dynamics.lv2 mod-mda-EPiano.lv2 mod-mda-Image.lv2 mod-mda-JX10.lv2 mod-mda-Leslie.lv2 mod-mda-Limiter.lv2 mod-mda-Loudness.lv2 mod-mda-MultiBand.lv2 mod-mda-Overdrive.lv2 mod-mda-Piano.lv2 mod-mda-RePsycho.lv2 mod-mda-RezFilter.lv2 mod-mda-RingMod.lv2 mod-mda-RoundPan.lv2 mod-mda-Shepard.lv2 mod-mda-Splitter.lv2 mod-mda-Stereo.lv2 mod-mda-SubSynth.lv2 mod-mda-TalkBox.lv2 mod-mda-TestTone.lv2 mod-mda-ThruZero.lv2 mod-mda-Tracker.lv2 mod-mda-Transient.lv2 mod-mda-VocInput.lv2 mod-mda-Vocoder.lv2

MOD_MDA_LV2_TARGET_WAF = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(HOST_DIR)/usr/bin/python2 ./waf

define MOD_MDA_LV2_CONFIGURE_CMDS
	(cd $(@D); $(MOD_MDA_LV2_TARGET_WAF) configure --prefix=/usr)
endef

define MOD_MDA_LV2_BUILD_CMDS
	(cd $(@D); $(MOD_MDA_LV2_TARGET_WAF) build -j $(PARALLEL_JOBS))
endef

define MOD_MDA_LV2_INSTALL_TARGET_CMDS
	(cd $(@D); $(MOD_MDA_LV2_TARGET_WAF) install --destdir=$(TARGET_DIR) -j 1)
	cp -rL $($(PKG)_PKGDIR)/mod-mda-Ambience.lv2/*  $(TARGET_DIR)/usr/lib/lv2/mod-mda-Ambience.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-Bandisto.lv2/*  $(TARGET_DIR)/usr/lib/lv2/mod-mda-Bandisto.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-BeatBox.lv2/*   $(TARGET_DIR)/usr/lib/lv2/mod-mda-BeatBox.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-Combo.lv2/*     $(TARGET_DIR)/usr/lib/lv2/mod-mda-Combo.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-DeEss.lv2/*     $(TARGET_DIR)/usr/lib/lv2/mod-mda-DeEss.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-Degrade.lv2/*   $(TARGET_DIR)/usr/lib/lv2/mod-mda-Degrade.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-Delay.lv2/*     $(TARGET_DIR)/usr/lib/lv2/mod-mda-Delay.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-Detune.lv2/*    $(TARGET_DIR)/usr/lib/lv2/mod-mda-Detune.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-Dither.lv2/*    $(TARGET_DIR)/usr/lib/lv2/mod-mda-Dither.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-DubDelay.lv2/*  $(TARGET_DIR)/usr/lib/lv2/mod-mda-DubDelay.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-Dynamics.lv2/*  $(TARGET_DIR)/usr/lib/lv2/mod-mda-Dynamics.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-DX10.lv2/*      $(TARGET_DIR)/usr/lib/lv2/mod-mda-DX10.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-EPiano.lv2/*    $(TARGET_DIR)/usr/lib/lv2/mod-mda-EPiano.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-Image.lv2/*     $(TARGET_DIR)/usr/lib/lv2/mod-mda-Image.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-JX10.lv2/*      $(TARGET_DIR)/usr/lib/lv2/mod-mda-JX10.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-Leslie.lv2/*    $(TARGET_DIR)/usr/lib/lv2/mod-mda-Leslie.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-Limiter.lv2/*   $(TARGET_DIR)/usr/lib/lv2/mod-mda-Limiter.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-Loudness.lv2/*  $(TARGET_DIR)/usr/lib/lv2/mod-mda-Loudness.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-MultiBand.lv2/* $(TARGET_DIR)/usr/lib/lv2/mod-mda-MultiBand.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-Overdrive.lv2/* $(TARGET_DIR)/usr/lib/lv2/mod-mda-Overdrive.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-Piano.lv2/*     $(TARGET_DIR)/usr/lib/lv2/mod-mda-Piano.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-RePsycho.lv2/*  $(TARGET_DIR)/usr/lib/lv2/mod-mda-RePsycho.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-RezFilter.lv2/* $(TARGET_DIR)/usr/lib/lv2/mod-mda-RezFilter.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-RingMod.lv2/*   $(TARGET_DIR)/usr/lib/lv2/mod-mda-RingMod.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-RoundPan.lv2/*  $(TARGET_DIR)/usr/lib/lv2/mod-mda-RoundPan.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-Shepard.lv2/*   $(TARGET_DIR)/usr/lib/lv2/mod-mda-Shepard.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-Splitter.lv2/*  $(TARGET_DIR)/usr/lib/lv2/mod-mda-Splitter.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-Stereo.lv2/*    $(TARGET_DIR)/usr/lib/lv2/mod-mda-Stereo.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-SubSynth.lv2/*  $(TARGET_DIR)/usr/lib/lv2/mod-mda-SubSynth.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-TalkBox.lv2/*   $(TARGET_DIR)/usr/lib/lv2/mod-mda-TalkBox.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-TestTone.lv2/*  $(TARGET_DIR)/usr/lib/lv2/mod-mda-TestTone.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-ThruZero.lv2/*  $(TARGET_DIR)/usr/lib/lv2/mod-mda-ThruZero.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-Tracker.lv2/*   $(TARGET_DIR)/usr/lib/lv2/mod-mda-Tracker.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-Transient.lv2/* $(TARGET_DIR)/usr/lib/lv2/mod-mda-Transient.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-VocInput.lv2/*  $(TARGET_DIR)/usr/lib/lv2/mod-mda-VocInput.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-Vocoder.lv2/*   $(TARGET_DIR)/usr/lib/lv2/mod-mda-Vocoder.lv2/
endef

$(eval $(generic-package))
