######################################
#
# lv2-examples
#
######################################

LV2_EXAMPLES_VERSION = a34ea338a347c4ebd3a190b60cde664d977412e8
LV2_EXAMPLES_SITE = $(call github,drobilla,lv2,$(LV2_EXAMPLES_VERSION))
LV2_EXAMPLES_DEPENDENCIES = host-python
LV2_EXAMPLES_BUNDLES = eg-amp.lv2 eg-fifths.lv2 eg-metro.lv2 eg-midigate.lv2 eg-sampler.lv2

LV2_EXAMPLES_TARGET_WAF = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(HOST_DIR)/usr/bin/python ./waf

define LV2_EXAMPLES_CONFIGURE_CMDS
	(cd $(@D); $(LV2_EXAMPLES_TARGET_WAF) configure --prefix=/usr)
endef

define LV2_EXAMPLES_BUILD_CMDS
	(cd $(@D); $(LV2_EXAMPLES_TARGET_WAF) build -j $(PARALLEL_JOBS))
endef

define LV2_EXAMPLES_INSTALL_TARGET_CMDS
	(cd $(@D); $(LV2_EXAMPLES_TARGET_WAF) install --destdir=$(TARGET_DIR))
endef

$(eval $(generic-package))
