################################################################################
#
# serd
#
################################################################################

SERD_VERSION = 32f10751605e7124e415d38feb4d8176288c03ad
SERD_SITE = $(call github,drobilla,serd,$(SERD_VERSION))
SERD_DEPENDENCIES = host-python
SERD_INSTALL_STAGING = YES
SERD_DEPENDENCIES = host-python

SERD_WAF = $(HOST_DIR)/usr/bin/python ./waf

define SERD_CONFIGURE_CMDS
	(cd $(@D); $(TARGET_CONFIGURE_OPTS) $(SERD_WAF) configure --prefix=/usr)
endef

define SERD_BUILD_CMDS
	(cd $(@D); $(SERD_WAF) build -j $(PARALLEL_JOBS))
endef

define SERD_INSTALL_TARGET_CMDS
	(cd $(@D); $(SERD_WAF) install --destdir=$(TARGET_DIR))
endef

define SERD_INSTALL_STAGING_CMDS
	(cd $(@D); $(SERD_WAF) install --destdir=$(STAGING_DIR))
endef

$(eval $(generic-package))
