######################################
#
# dpf
#
######################################

DPF_VERSION = e045225a6c08d437d0bcf8400da9b0783291b4a9
DPF_SITE = $(call github,DISTRHO,DPF,$(DPF_VERSION))
DPF_INSTALL_STAGING = YES

define DPF_INSTALL_STAGING_CMDS
	$(INSTALL) -d $(STAGING_DIR)/usr/src/dpf
	cp -r $(@D)/* $(STAGING_DIR)/usr/src/dpf/
endef

$(eval $(generic-package))
