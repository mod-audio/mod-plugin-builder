################################################################################
#
# lilv
#
################################################################################

LILV_VERSION = c98879fd3562c48049c2c65369050f267c8358d6
LILV_SITE = http://git.drobilla.net/lilv.git
LILV_SITE_METHOD = git
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
