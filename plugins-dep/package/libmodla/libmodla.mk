######################################
#
# libmodla
#
######################################

ifdef BR2_cortex_a53
LIBMODLA_SOURCE_SUFFIX = aarch64-a53
else ifdef BR2_cortex_a35
LIBMODLA_SOURCE_SUFFIX = aarch64-a35
else
LIBMODLA_SOURCE_SUFFIX = arm-a7
endif

LIBMODLA_VERSION = v1.2.3
LIBMODLA_SITE = http://web1.moddevices.com/shared
LIBMODLA_SOURCE = libmodla-$(LIBMODLA_VERSION)-$(LIBMODLA_SOURCE_SUFFIX).tar.gz
LIBMODLA_INSTALL_STAGING = YES

define LIBMODLA_INSTALL_STAGING_CMDS
	(cd $(@D); install -m 644 mod-license.h libmodla.h $(STAGING_DIR)/usr/include)
	(cd $(@D); install -m 644 libmodla.a $(STAGING_DIR)/usr/lib)
endef

$(eval $(generic-package))
