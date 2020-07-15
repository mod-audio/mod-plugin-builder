######################################
#
# rkrlv2
#
######################################

RKRLV2_VERSION = 7edcb4e29a358623bfd57fa2c27e5da60adfcec3
RKRLV2_SITE = $(call github,ssj71,rkrlv2,$(RKRLV2_VERSION))
RKRLV2_DEPENDENCIES = fftw-double libsamplerate
RKRLV2_BUNDLES = rkr.lv2

define RKRLV2_POST_INSTALL_TARGET_TTLFILES
	cp -rL $($(PKG)_PKGDIR)/rkr.lv2/* $(TARGET_DIR)/usr/lib/lv2/rkr.lv2/
endef

RKRLV2_POST_INSTALL_TARGET_HOOKS += RKRLV2_POST_INSTALL_TARGET_TTLFILES

$(eval $(cmake-package))
