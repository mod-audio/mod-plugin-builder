######################################
#
# lvtk-1
#
######################################

LVTK_1_VERSION = c105fd5077b4f7d963ad543b9979b94b9b052551
LVTK_1_SITE = $(call github,lvtk,lvtk,$(LVTK_1_VERSION))
LVTK_1_DEPENDENCIES = boost lv2 host-python
LVTK_1_INSTALL_STAGING = YES

LVTK_1_WAF = $(HOST_DIR)/usr/bin/python2 ./waf

define LVTK_1_CONFIGURE_CMDS
	(cd $(@D); $(TARGET_CONFIGURE_OPTS) $(LVTK_1_WAF) configure \
		--prefix=/usr      \
		--disable-examples \
		--disable-tools    \
		--disable-ui)
endef

define LVTK_1_BUILD_CMDS
	(cd $(@D); $(LVTK_1_WAF) build -j $(PARALLEL_JOBS))
endef

define LVTK_1_INSTALL_TARGET_CMDS
	(cd $(@D); $(LVTK_1_WAF) install --destdir=$(TARGET_DIR))
endef

define LVTK_1_INSTALL_STAGING_CMDS
	(cd $(@D); $(LVTK_1_WAF) install --destdir=$(STAGING_DIR))
endef

$(eval $(generic-package))
