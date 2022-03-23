######################################
#
# mod-mda-lv2-labs
#
######################################

MOD_MDA_LV2_LABS_VERSION = bbd8da8b869af15c5fc99ae844591d3848d2a4a9
MOD_MDA_LV2_LABS_SITE = $(call github,moddevices,mda-lv2,$(MOD_MDA_LV2_LABS_VERSION))
MOD_MDA_LV2_LABS_BUNDLES = mod-mda-Bandisto.lv2 mod-mda-Combo.lv2 mod-mda-DeEss.lv2 mod-mda-Degrade.lv2 mod-mda-Delay.lv2 mod-mda-Dither.lv2 mod-mda-Dynamics.lv2 mod-mda-Image.lv2 mod-mda-Limiter.lv2 mod-mda-Loudness.lv2 mod-mda-MultiBand.lv2 mod-mda-RezFilter.lv2 mod-mda-Shepard.lv2 mod-mda-Splitter.lv2 mod-mda-Stereo.lv2 mod-mda-TalkBox.lv2 mod-mda-TestTone.lv2 mod-mda-Tracker.lv2 mod-mda-Transient.lv2 mod-mda-VocInput.lv2

MOD_MDA_LV2_LABS_TARGET_WAF = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(HOST_DIR)/usr/bin/python2 ./waf

define MOD_MDA_LV2_LABS_CONFIGURE_CMDS
	(cd $(@D); $(MOD_MDA_LV2_LABS_TARGET_WAF) configure --prefix=/usr)
endef

define MOD_MDA_LV2_LABS_BUILD_CMDS
	(cd $(@D); $(MOD_MDA_LV2_LABS_TARGET_WAF) build -j $(PARALLEL_JOBS))
endef

define MOD_MDA_LV2_LABS_INSTALL_TARGET_CMDS
	# make sure to delete old files
	rm -rf $(TARGET_DIR)/usr/lib/lv2/mod-mda-*.lv2/
	# install fresh
	(cd $(@D); $(MOD_MDA_LV2_LABS_TARGET_WAF) install --destdir=$(TARGET_DIR) -j 1)
	# and ship with our custom bundles
	cp -rL $($(PKG)_PKGDIR)/mod-mda-Bandisto.lv2/*  $(TARGET_DIR)/usr/lib/lv2/mod-mda-Bandisto.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-Combo.lv2/*     $(TARGET_DIR)/usr/lib/lv2/mod-mda-Combo.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-DeEss.lv2/*     $(TARGET_DIR)/usr/lib/lv2/mod-mda-DeEss.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-Degrade.lv2/*   $(TARGET_DIR)/usr/lib/lv2/mod-mda-Degrade.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-Delay.lv2/*     $(TARGET_DIR)/usr/lib/lv2/mod-mda-Delay.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-Dither.lv2/*    $(TARGET_DIR)/usr/lib/lv2/mod-mda-Dither.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-Dynamics.lv2/*  $(TARGET_DIR)/usr/lib/lv2/mod-mda-Dynamics.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-Image.lv2/*     $(TARGET_DIR)/usr/lib/lv2/mod-mda-Image.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-Limiter.lv2/*   $(TARGET_DIR)/usr/lib/lv2/mod-mda-Limiter.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-Loudness.lv2/*  $(TARGET_DIR)/usr/lib/lv2/mod-mda-Loudness.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-MultiBand.lv2/* $(TARGET_DIR)/usr/lib/lv2/mod-mda-MultiBand.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-RezFilter.lv2/* $(TARGET_DIR)/usr/lib/lv2/mod-mda-RezFilter.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-Shepard.lv2/*   $(TARGET_DIR)/usr/lib/lv2/mod-mda-Shepard.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-Splitter.lv2/*  $(TARGET_DIR)/usr/lib/lv2/mod-mda-Splitter.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-Stereo.lv2/*    $(TARGET_DIR)/usr/lib/lv2/mod-mda-Stereo.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-TalkBox.lv2/*   $(TARGET_DIR)/usr/lib/lv2/mod-mda-TalkBox.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-TestTone.lv2/*  $(TARGET_DIR)/usr/lib/lv2/mod-mda-TestTone.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-Tracker.lv2/*   $(TARGET_DIR)/usr/lib/lv2/mod-mda-Tracker.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-Transient.lv2/* $(TARGET_DIR)/usr/lib/lv2/mod-mda-Transient.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mda-VocInput.lv2/*  $(TARGET_DIR)/usr/lib/lv2/mod-mda-VocInput.lv2/
endef

$(eval $(generic-package))
