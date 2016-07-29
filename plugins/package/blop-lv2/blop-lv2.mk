######################################
#
# blop-lv2
#
######################################

BLOP_LV2_VERSION = 25451be928b69c288f6978fb3b3fcf202dbd1ee1
BLOP_LV2_SITE = http://git.drobilla.net/blop.lv2.git
BLOP_LV2_SITE_METHOD = git
BLOP_LV2_BUNDLES = blop.lv2

BLOP_TARGET_WAF = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(HOST_DIR)/usr/bin/python ./waf

define BLOP_LV2_CONFIGURE_CMDS
	(cd $(@D); $(BLOP_TARGET_WAF) configure --prefix=/usr)
endef

define BLOP_LV2_BUILD_CMDS
	(cd $(@D); $(BLOP_TARGET_WAF) build -j $(PARALLEL_JOBS))
endef

define BLOP_LV2_INSTALL_TARGET_CMDS
	(cd $(@D); $(BLOP_TARGET_WAF) install --destdir=$(TARGET_DIR))
	cp -rL $($(PKG)_PKGDIR)/blop.lv2/* $(TARGET_DIR)/usr/lib/lv2/blop.lv2/
endef

$(eval $(generic-package))
