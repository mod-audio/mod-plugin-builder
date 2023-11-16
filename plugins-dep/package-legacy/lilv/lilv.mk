################################################################################
#
# lilv
#
################################################################################

LILV_VERSION = a208ffd4776ebc9072bfca2603d6931e24917ccf
LILV_SITE = $(call github,drobilla,lilv,$(LILV_VERSION))
LILV_DEPENDENCIES = sratom
LILV_INSTALL_STAGING = YES

LILV_WAF = $(HOST_DIR)/usr/bin/python ./waf

define LILV_CONFIGURE_CMDS
	(cd $(@D); $(TARGET_CONFIGURE_OPTS) $(LILV_WAF) configure --prefix=/usr)
endef

define LILV_BUILD_CMDS
	(cd $(@D); $(LILV_WAF) build -j $(PARALLEL_JOBS))
endef

define LILV_INSTALL_TARGET_CMDS
	(cd $(@D); $(LILV_WAF) install --destdir=$(TARGET_DIR))
endef

define LILV_INSTALL_STAGING_CMDS
	(cd $(@D); $(LILV_WAF) install --destdir=$(STAGING_DIR))
endef

$(eval $(generic-package))
