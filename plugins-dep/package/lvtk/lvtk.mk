######################################
#
# lvtk
#
######################################

LVTK_VERSION = 065830b1e88e4a152eafbe963c325554983fcfe4
LVTK_SITE = $(call github,lvtk,lvtk,$(LVTK_VERSION))
LVTK_DEPENDENCIES = lv2 host-python
LVTK_INSTALL_STAGING = YES

LVTK_WAF = $(HOST_DIR)/usr/bin/python2 ./waf

define LVTK_CONFIGURE_CMDS
	(cd $(@D); $(TARGET_CONFIGURE_OPTS) $(LVTK_WAF) configure \
		--prefix=/usr      \
		--disable-examples \
		--disable-tools    \
		--disable-ui)
endef

define LVTK_BUILD_CMDS
	(cd $(@D); $(LVTK_WAF) build -j $(PARALLEL_JOBS))
endef

define LVTK_INSTALL_TARGET_CMDS
	(cd $(@D); $(LVTK_WAF) install --destdir=$(TARGET_DIR))
endef

define LVTK_INSTALL_STAGING_CMDS
	(cd $(@D); $(LVTK_WAF) install --destdir=$(STAGING_DIR))
endef

$(eval $(generic-package))
