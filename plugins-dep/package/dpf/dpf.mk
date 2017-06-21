######################################
#
# dpf
#
######################################

DPF_VERSION = aad10058029ec4afe209b099a1ac8e2e8c8a2f25
DPF_SITE = $(call github,DISTRHO,DPF,$(DPF_VERSION))
DPF_INSTALL_STAGING = YES

define DPF_INSTALL_STAGING_CMDS
	rm -rf $(STAGING_DIR)/usr/include/dpf
	$(INSTALL) -d $(STAGING_DIR)/usr/include/dpf
	cp -r $(@D)/distrho $(STAGING_DIR)/usr/include/dpf/
endef

$(eval $(generic-package))
