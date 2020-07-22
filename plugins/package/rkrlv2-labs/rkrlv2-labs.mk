######################################
#
# rkrlv2-labs
#
######################################

RKRLV2_LABS_VERSION = 058fecf367b2d20e140828869822391217783a82
RKRLV2_LABS_SITE = $(call github,ssj71,rkrlv2,$(RKRLV2_LABS_VERSION))
RKRLV2_LABS_DEPENDENCIES = fftw-double libsamplerate
RKRLV2_LABS_BUNDLES = rkr-labs.lv2

define RKRLV2_LABS_POST_INSTALL_TARGET_TTLFILES
	mv $(TARGET_DIR)/usr/lib/lv2/rkr.lv2 $(TARGET_DIR)/usr/lib/lv2/rkr-labs.lv2
	cp -rL $($(PKG)_PKGDIR)/rkr-labs.lv2/* $(TARGET_DIR)/usr/lib/lv2/rkr-labs.lv2/
endef

RKRLV2_LABS_POST_INSTALL_TARGET_HOOKS += RKRLV2_LABS_POST_INSTALL_TARGET_TTLFILES

$(eval $(cmake-package))
