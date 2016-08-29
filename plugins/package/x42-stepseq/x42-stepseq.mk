######################################
#
# x42-stepseq
#
######################################

X42_STEPSEQ_VERSION = b9e02d81415b664069ac2b98d776e256e11b0c53
X42_STEPSEQ_SITE = $(call github,x42,stepseq.lv2,$(X42_STEPSEQ_VERSION))
X42_STEPSEQ_BUNDLES = stepseq_s8n4.lv2 stepseq_s8n8.lv2 stepseq_s8n16.lv2

X42_STEPSEQ_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) MOD=1 OPTIMIZATIONS="-fno-finite-math-only" PREFIX=/usr -C $(@D)

define X42_STEPSEQ_BUILD_CMDS
endef

define X42_STEPSEQ_INSTALL_TARGET_CMDS
	# 8x4 version
	$(X42_STEPSEQ_TARGET_MAKE) clean
	$(X42_STEPSEQ_TARGET_MAKE) N_STEPS=8 N_NOTES=4 install DESTDIR=$(TARGET_DIR)
	cp -rL $($(PKG)_PKGDIR)/stepseq_s8n4.lv2/*  $(TARGET_DIR)/usr/lib/lv2/stepseq_s8n4.lv2/

	# 8x8 version
	$(X42_STEPSEQ_TARGET_MAKE) clean
	$(X42_STEPSEQ_TARGET_MAKE) N_STEPS=8 N_NOTES=8 install DESTDIR=$(TARGET_DIR)
	cp -rL $($(PKG)_PKGDIR)/stepseq_s8n8.lv2/*  $(TARGET_DIR)/usr/lib/lv2/stepseq_s8n8.lv2/

	# 8x16 version
	$(X42_STEPSEQ_TARGET_MAKE) clean
	$(X42_STEPSEQ_TARGET_MAKE) N_STEPS=8 N_NOTES=16 install DESTDIR=$(TARGET_DIR)
	cp -rL $($(PKG)_PKGDIR)/stepseq_s8n16.lv2/* $(TARGET_DIR)/usr/lib/lv2/stepseq_s8n16.lv2/
endef

$(eval $(generic-package))
