################################################################################
#
# sord
#
################################################################################

SORD_VERSION = 31ea384f24e12778d6e30cc7a30b0f48f3d50523
SORD_SITE = http://git.drobilla.net/sord.git
SORD_SITE_METHOD = git
SORD_DEPENDENCIES = serd
SORD_INSTALL_STAGING = YES

SORD_WAF = $(HOST_DIR)/usr/bin/python ./waf

define SORD_CONFIGURE_CMDS
	(cd $(@D); $(TARGET_CONFIGURE_OPTS) $(SORD_WAF) configure --prefix=/usr)
endef

define SORD_BUILD_CMDS
	(cd $(@D); $(SORD_WAF) build -j $(PARALLEL_JOBS))
endef

define SORD_INSTALL_TARGET_CMDS
	(cd $(@D); $(SORD_WAF) install --destdir=$(TARGET_DIR))
endef

define SORD_INSTALL_STAGING_CMDS
	(cd $(@D); $(SORD_WAF) install --destdir=$(STAGING_DIR))
endef

$(eval $(generic-package))
