################################################################################
#
# serd
#
################################################################################

SERD_VERSION = 83de3f80ca6cbbaac35c003bba9d6625db525939
SERD_SITE = http://git.drobilla.net/serd.git
SERD_SITE_METHOD = git
SERD_DEPENDENCIES = host-python
SERD_INSTALL_STAGING = YES

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
