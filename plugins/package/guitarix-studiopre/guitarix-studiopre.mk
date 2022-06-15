######################################
#
# guitarix-studiopre
#
######################################

GUITARIX_STUDIOPRE_VERSION = 589dd79b2d7ad2b5e0db4c18c25279d6e94a1552
GUITARIX_STUDIOPRE_SITE = $(call github,moddevices,guitarix,$(GUITARIX_STUDIOPRE_VERSION))
GUITARIX_STUDIOPRE_DEPENDENCIES = boost eigen fftw-single glibmm libsndfile zita-convolver zita-resampler host-python host-intltool
GUITARIX_STUDIOPRE_BUNDLES = gx_studiopre.lv2 gx_studiopre_st.lv2

GUITARIX_STUDIOPRE_TARGET_WAF = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) EIGEN3_PATH=$(STAGING_DIR)/usr/include/eigen3/ $(HOST_DIR)/usr/bin/python2 ./waf

define GUITARIX_STUDIOPRE_CONFIGURE_CMDS
	(cd $(@D)/trunk; $(GUITARIX_STUDIOPRE_TARGET_WAF) configure --prefix=/usr --disable-sse --lv2-only --no-lv2-gui --no-faust)
endef

define GUITARIX_STUDIOPRE_BUILD_CMDS
	(cd $(@D)/trunk; $(GUITARIX_STUDIOPRE_TARGET_WAF) build -j $(PARALLEL_JOBS))
endef

define GUITARIX_STUDIOPRE_INSTALL_TARGET_CMDS
	(cd $(@D)/trunk; $(GUITARIX_STUDIOPRE_TARGET_WAF) install --destdir=$(TARGET_DIR))
	cp -rL $($(PKG)_PKGDIR)/gx_studiopre.lv2/*    $(TARGET_DIR)/usr/lib/lv2/gx_studiopre.lv2/
	cp -rL $($(PKG)_PKGDIR)/gx_studiopre_st.lv2/* $(TARGET_DIR)/usr/lib/lv2/gx_studiopre_st.lv2/
endef

$(eval $(generic-package))
