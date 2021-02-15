######################################
#
# samplv1
#
######################################

SAMPLV1_VERSION = 81436fe8c18fc80aef0cd163c3194934229e9f13
SAMPLV1_SITE = $(call github,moddevices,samplv1,$(SAMPLV1_VERSION))
SAMPLV1_BUNDLES = samplv1.lv2
SAMPLV1_AUTORECONF = YES

SAMPLV1_CONF_OPTS=--disable-jack --disable-lv2-ui-x11 --disable-lv2-ui-external --enable-lv2-port-event=no

define SAMPLV1_COPY_LV2_DATA
	cp -rL $($(PKG)_PKGDIR)$(SAMPLV1_BUNDLES)/* $(TARGET_DIR)/usr/lib/lv2/$(SAMPLV1_BUNDLES)
endef

SAMPLV1_POST_INSTALL_TARGET_HOOKS += SAMPLV1_COPY_LV2_DATA

$(eval $(autotools-package))
