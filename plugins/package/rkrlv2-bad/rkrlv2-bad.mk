######################################
#
# rkrlv2-bad
#
######################################

RKRLV2_BAD_VERSION = 058fecf367b2d20e140828869822391217783a82
RKRLV2_BAD_SITE = $(call github,ssj71,rkrlv2,$(RKRLV2_BAD_VERSION))
RKRLV2_BAD_DEPENDENCIES = fftw-double libsamplerate
RKRLV2_BAD_BUNDLES = rkr-bad.lv2

define RKRLV2_BAD_POST_INSTALL_TARGET_TTLFILES
	mv $(TARGET_DIR)/usr/lib/lv2/rkr.lv2 $(TARGET_DIR)/usr/lib/lv2/rkr-bad.lv2
	cp -rL $($(PKG)_PKGDIR)/rkr-bad.lv2/* $(TARGET_DIR)/usr/lib/lv2/rkr-bad.lv2/
endef

RKRLV2_BAD_POST_INSTALL_TARGET_HOOKS += RKRLV2_BAD_POST_INSTALL_TARGET_TTLFILES

$(eval $(cmake-package))
