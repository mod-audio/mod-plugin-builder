################################################################################
#
# sratom
#
################################################################################

SRATOM_VERSION = b9717ab942b38f023cee99b3c108514a651b2b51
SRATOM_SITE = http://git.drobilla.net/sratom.git
SRATOM_SITE_METHOD = git
SRATOM_DEPENDENCIES = lv2 sord
SRATOM_INSTALL_STAGING = YES

SRATOM_WAF = $(HOST_DIR)/usr/bin/python ./waf

define SRATOM_CONFIGURE_CMDS
	(cd $(@D); $(TARGET_CONFIGURE_OPTS) $(SRATOM_WAF) configure --prefix=/usr)
endef

define SRATOM_BUILD_CMDS
	(cd $(@D); $(SRATOM_WAF) build -j $(PARALLEL_JOBS))
endef

define SRATOM_INSTALL_TARGET_CMDS
	(cd $(@D); $(SRATOM_WAF) install --destdir=$(TARGET_DIR))
endef

define SRATOM_INSTALL_STAGING_CMDS
	(cd $(@D); $(SRATOM_WAF) install --destdir=$(STAGING_DIR))
endef

$(eval $(generic-package))
