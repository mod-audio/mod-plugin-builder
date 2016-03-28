################################################################################
#
# lv2
#
################################################################################

LV2_VERSION = a34ea338a347c4ebd3a190b60cde664d977412e8
LV2_SITE = $(call github,drobilla,lv2,$(LV2_VERSION))
LV2_LICENSE = ISC License
LV2_LICENSE_FILES = COPYING
LV2_INSTALL_STAGING = YES
LV2_DEPENDENCIES = host-python

LV2_HOST_WAF   = $(HOST_MAKE_ENV)   $(HOST_CONFIGURE_OPTS)   $(HOST_DIR)/usr/bin/python2 ./waf
LV2_TARGET_WAF = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(HOST_DIR)/usr/bin/python2 ./waf

define HOST_LV2_CONFIGURE_CMDS
	(cd $(@D); $(LV2_HOST_WAF) configure --prefix=/usr --no-plugins)
endef

define HOST_LV2_BUILD_CMDS
	(cd $(@D); $(LV2_HOST_WAF) build -j $(PARALLEL_JOBS))
	# FIXME: make buildroot install host package in its own step
	(cd $(@D); $(LV2_HOST_WAF) install --destdir=$(HOST_DIR))
endef

define LV2_CONFIGURE_CMDS
	(cd $(@D); $(LV2_TARGET_WAF) configure --prefix=/usr --no-plugins)
endef

define LV2_BUILD_CMDS
	(cd $(@D); $(LV2_TARGET_WAF) build -j $(PARALLEL_JOBS))
endef

define LV2_INSTALL_TARGET_CMDS
	(cd $(@D); $(LV2_TARGET_WAF) install --destdir=$(TARGET_DIR))
endef

define LV2_INSTALL_STAGING_CMDS
	(cd $(@D); $(LV2_TARGET_WAF) install --destdir=$(STAGING_DIR))
endef

$(eval $(generic-package))
$(eval $(host-generic-package))

