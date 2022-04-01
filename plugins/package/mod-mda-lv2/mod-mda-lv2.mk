######################################
#
# mod-mda-lv2
#
######################################

MOD_MDA_LV2_VERSION = 99a2131d37c07f36d11cb375d2f6033d55165c2c
MOD_MDA_LV2_SITE = $(call github,moddevices,mda-lv2,$(MOD_MDA_LV2_VERSION))
MOD_MDA_LV2_BUNDLES = mod-mda-Ambience.lv2 mod-mda-BeatBox.lv2 mod-mda-Degrade.lv2 mod-mda-Detune.lv2 mod-mda-DubDelay.lv2 mod-mda-DX10.lv2 mod-mda-EPiano.lv2 mod-mda-JX10.lv2 mod-mda-Leslie.lv2 mod-mda-Overdrive.lv2 mod-mda-Piano.lv2 mod-mda-RePsycho.lv2 mod-mda-RingMod.lv2 mod-mda-RoundPan.lv2 mod-mda-Shepard.lv2 mod-mda-SubSynth.lv2 mod-mda-ThruZero.lv2 mod-mda-Vocoder.lv2

MOD_MDA_LV2_TARGET_WAF = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(HOST_DIR)/usr/bin/python2 ./waf

define MOD_MDA_LV2_CONFIGURE_CMDS
	(cd $(@D); $(MOD_MDA_LV2_TARGET_WAF) configure --prefix=/usr)
endef

define MOD_MDA_LV2_BUILD_CMDS
	(cd $(@D); $(MOD_MDA_LV2_TARGET_WAF) build -j $(PARALLEL_JOBS))
endef

define MOD_MDA_LV2_INSTALL_TARGET_CMDS
	# make sure to delete old files
	rm -rf $(TARGET_DIR)/usr/lib/lv2/mod-mda-*.lv2/
	# install fresh
	(cd $(@D); $(MOD_MDA_LV2_TARGET_WAF) install --destdir=$(TARGET_DIR) -j 1)
	# and ship with our custom bundles
	cp -rL $($(PKG)_PKGDIR)/mod-mda-Ambience.lv2/*  $(TARGET_DIR)/usr/lib/lv2/mod-mda-Ambience.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-BeatBox.lv2/*   $(TARGET_DIR)/usr/lib/lv2/mod-mda-BeatBox.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-Degrade.lv2/*   $(TARGET_DIR)/usr/lib/lv2/mod-mda-Degrade.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-Detune.lv2/*    $(TARGET_DIR)/usr/lib/lv2/mod-mda-Detune.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-DubDelay.lv2/*  $(TARGET_DIR)/usr/lib/lv2/mod-mda-DubDelay.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-DX10.lv2/*      $(TARGET_DIR)/usr/lib/lv2/mod-mda-DX10.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-EPiano.lv2/*    $(TARGET_DIR)/usr/lib/lv2/mod-mda-EPiano.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-JX10.lv2/*      $(TARGET_DIR)/usr/lib/lv2/mod-mda-JX10.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-Leslie.lv2/*    $(TARGET_DIR)/usr/lib/lv2/mod-mda-Leslie.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-Overdrive.lv2/* $(TARGET_DIR)/usr/lib/lv2/mod-mda-Overdrive.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-Piano.lv2/*     $(TARGET_DIR)/usr/lib/lv2/mod-mda-Piano.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-RePsycho.lv2/*  $(TARGET_DIR)/usr/lib/lv2/mod-mda-RePsycho.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-RingMod.lv2/*   $(TARGET_DIR)/usr/lib/lv2/mod-mda-RingMod.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-RoundPan.lv2/*  $(TARGET_DIR)/usr/lib/lv2/mod-mda-RoundPan.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-Shepard.lv2/*   $(TARGET_DIR)/usr/lib/lv2/mod-mda-Shepard.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-SubSynth.lv2/*  $(TARGET_DIR)/usr/lib/lv2/mod-mda-SubSynth.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-ThruZero.lv2/*  $(TARGET_DIR)/usr/lib/lv2/mod-mda-ThruZero.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-Vocoder.lv2/*   $(TARGET_DIR)/usr/lib/lv2/mod-mda-Vocoder.lv2/
endef

$(eval $(generic-package))
