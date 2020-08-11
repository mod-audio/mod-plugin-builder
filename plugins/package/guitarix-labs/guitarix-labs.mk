######################################
#
# guitarix-labs
#
######################################

GUITARIX_LABS_VERSION = 589dd79b2d7ad2b5e0db4c18c25279d6e94a1552
GUITARIX_LABS_SITE = $(call github,moddevices,guitarix,$(GUITARIX_LABS_VERSION))
GUITARIX_LABS_DEPENDENCIES = boost eigen fftw-single glibmm libsndfile zita-convolver zita-resampler host-python host-intltool
GUITARIX_LABS_BUNDLES = gx_barkgraphiceq.lv2 gx_chorus.lv2 gx_graphiceq.lv2 gx_livelooper.lv2 gx_mbcompressor.lv2 gx_mbdistortion.lv2 gx_mbecho.lv2 gx_mbreverb.lv2 gx_tremolo.lv2 gx_zita_rev1.lv2 gxautowah.lv2 gxechocat.lv2 gxtubedelay.lv2 gxtubetremelo.lv2 gxtubevibrato.lv2 gxtuner.lv2

GUITARIX_LABS_TARGET_WAF = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) EIGEN3_PATH=$(STAGING_DIR)/usr/include/eigen3/ $(HOST_DIR)/usr/bin/python2 ./waf

define GUITARIX_LABS_CONFIGURE_CMDS
	(cd $(@D)/trunk; $(GUITARIX_LABS_TARGET_WAF) configure --prefix=/usr --disable-sse --lv2-only --no-lv2-gui --no-faust)
endef

define GUITARIX_LABS_BUILD_CMDS
	(cd $(@D)/trunk; $(GUITARIX_LABS_TARGET_WAF) build -j $(PARALLEL_JOBS))
endef

define GUITARIX_LABS_INSTALL_TARGET_CMDS
	(cd $(@D)/trunk; $(GUITARIX_LABS_TARGET_WAF) install --destdir=$(TARGET_DIR))
	cp -rL $($(PKG)_PKGDIR)/gx_barkgraphiceq.lv2/* $(TARGET_DIR)/usr/lib/lv2/gx_barkgraphiceq.lv2/
	cp -rL $($(PKG)_PKGDIR)/gx_chorus.lv2/*        $(TARGET_DIR)/usr/lib/lv2/gx_chorus.lv2/
	cp -rL $($(PKG)_PKGDIR)/gx_graphiceq.lv2/*     $(TARGET_DIR)/usr/lib/lv2/gx_graphiceq.lv2/
	cp -rL $($(PKG)_PKGDIR)/gx_livelooper.lv2/*    $(TARGET_DIR)/usr/lib/lv2/gx_livelooper.lv2/
	cp -rL $($(PKG)_PKGDIR)/gx_mbcompressor.lv2/*  $(TARGET_DIR)/usr/lib/lv2/gx_mbcompressor.lv2/
	cp -rL $($(PKG)_PKGDIR)/gx_mbdistortion.lv2/*  $(TARGET_DIR)/usr/lib/lv2/gx_mbdistortion.lv2/
	cp -rL $($(PKG)_PKGDIR)/gx_mbecho.lv2/*        $(TARGET_DIR)/usr/lib/lv2/gx_mbecho.lv2/
	cp -rL $($(PKG)_PKGDIR)/gx_mbreverb.lv2/*      $(TARGET_DIR)/usr/lib/lv2/gx_mbreverb.lv2/
	cp -rL $($(PKG)_PKGDIR)/gx_tremolo.lv2/*       $(TARGET_DIR)/usr/lib/lv2/gx_tremolo.lv2/
	cp -rL $($(PKG)_PKGDIR)/gx_zita_rev1.lv2/*     $(TARGET_DIR)/usr/lib/lv2/gx_zita_rev1.lv2/
	cp -rL $($(PKG)_PKGDIR)/gxautowah.lv2/*        $(TARGET_DIR)/usr/lib/lv2/gxautowah.lv2/
	cp -rL $($(PKG)_PKGDIR)/gxechocat.lv2/*        $(TARGET_DIR)/usr/lib/lv2/gxechocat.lv2/
	cp -rL $($(PKG)_PKGDIR)/gxtubedelay.lv2/*      $(TARGET_DIR)/usr/lib/lv2/gxtubedelay.lv2/
	cp -rL $($(PKG)_PKGDIR)/gxtubetremelo.lv2/*    $(TARGET_DIR)/usr/lib/lv2/gxtubetremelo.lv2/
	cp -rL $($(PKG)_PKGDIR)/gxtubevibrato.lv2/*    $(TARGET_DIR)/usr/lib/lv2/gxtubevibrato.lv2/
	cp -rL $($(PKG)_PKGDIR)/gxtuner.lv2/*          $(TARGET_DIR)/usr/lib/lv2/gxtuner.lv2/
	# broken plugins
	rm -rf $(TARGET_DIR)/usr/lib/lv2/gx_vibe.lv2/
endef

$(eval $(generic-package))
