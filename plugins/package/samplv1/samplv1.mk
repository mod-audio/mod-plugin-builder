######################################
#
# samplv1
#
######################################

SAMPLV1_VERSION = 38136d42e495c48dad4bed9a0e48cf8a46b20b2a
SAMPLV1_SITE = $(call github,moddevices,samplv1,$(SAMPLV1_VERSION))
SAMPLV1_BUNDLES = samplv1.lv2
SAMPLV1_AUTORECONF = YES

SAMPLV1_CONF_OPTS=--disable-jack --disable-lv2-ui-x11 --disable-lv2-ui-external

define MOD_TAL_NOISEMAKER_CONFIGURE_CMDS
       (cd $(@D); ./autogen.sh)
endef

define SAMPLV1_COPY_LV2_DATA
	cp -rL $($(PKG)_PKGDIR)$(SAMPLV1_BUNDLES)/* $(TARGET_DIR)/usr/lib/lv2/$(SAMPLV1_BUNDLES)
endef

SAMPLV1_POST_INSTALL_TARGET_HOOKS += SAMPLV1_COPY_LV2_DATA

$(eval $(autotools-package))
