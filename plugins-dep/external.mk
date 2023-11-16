include $(sort $(wildcard $(BR2_EXTERNAL_PLUGINS_DEP)/package/*/*.mk))
ifeq ($(BR2_VERSION),2016.02)
include $(sort $(wildcard $(BR2_EXTERNAL_PLUGINS_DEP)/package-legacy/*/*.mk))
endif
include $(sort $(wildcard $(BR2_EXTERNAL_PLUGINS_DEP)/../plugins/package/*/*.mk))
