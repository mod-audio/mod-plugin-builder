######################################
#
# dpf
#
######################################

DPF_VERSION = 6b042628933f220a05571bde6a02fe0198a96b5d
DPF_SITE = $(call github,DISTRHO,DPF,$(DPF_VERSION))
DPF_INSTALL_STAGING = YES

define DPF_INSTALL_STAGING_CMDS
	$(INSTALL) -d $(STAGING_DIR)/usr/src/dpf
	cp -r $(@D)/* $(STAGING_DIR)/usr/src/dpf/
endef

$(eval $(generic-package))
