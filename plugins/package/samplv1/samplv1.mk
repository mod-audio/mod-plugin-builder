######################################
#
# samplv1
#
######################################

SAMPLV1_VERSION = 85c688e833b43adcfde1045ed4933c72ab85c987
SAMPLV1_SITE = $(call github,moddevices,samplv1,$(SAMPLV1_VERSION))
SAMPLV1_BUNDLES = samplv1.lv2
SAMPLV1_AUTORECONF = YES

SAMPLV1_CONF_OPTS=--disable-jack --disable-lv2-ui-x11 --disable-lv2-ui-external --enable-lv2-port-event=no

define SAMPLV1_CONFIGURE_CMDS
       (cd $(@D); ./autogen.sh)
endef

define SAMPLV1_COPY_LV2_DATA
	cp -rL $($(PKG)_PKGDIR)$(SAMPLV1_BUNDLES)/* $(TARGET_DIR)/usr/lib/lv2/$(SAMPLV1_BUNDLES)
endef

SAMPLV1_POST_INSTALL_TARGET_HOOKS += SAMPLV1_COPY_LV2_DATA

$(eval $(autotools-package))
