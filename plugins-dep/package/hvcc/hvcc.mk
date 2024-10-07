######################################
#
# hvcc
#
######################################

# taken from https://github.com/Wasted-Audio/hvcc/actions/runs/11177587501/artifacts/2015031571
HVCC_SITE = https://falktx.berlin/data/mod
HVCC_VERSION = 0.12.1+git20240710
HVCC_SOURCE = hvcc-$(HVCC_VERSION).tar.gz
HVCC_INSTALL_STAGING = YES

define HVCC_INSTALL_STAGING_CMDS
	$(INSTALL) -d $(STAGING_DIR)/usr/bin
	install -m 755 $(@D)/hvcc $(STAGING_DIR)/usr/bin/
endef

$(eval $(generic-package))
