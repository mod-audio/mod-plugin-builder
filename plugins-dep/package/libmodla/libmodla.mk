######################################
#
# libmodla
#
######################################

ifeq ($(BR2_PACKAGE_LIBMODLA_PABLITO),y)
LIBMODLA_SOURCE_SUFFIX = pablito
else ifdef BR2_cortex_a53
LIBMODLA_SOURCE_SUFFIX = aarch64-a53
else ifdef BR2_cortex_a35
LIBMODLA_SOURCE_SUFFIX = aarch64-a35
else
LIBMODLA_SOURCE_SUFFIX = arm-a7
endif

ifeq ($(filter arm-% aarch64-%,$(LIBMODLA_SOURCE_SUFFIX)),)
# nothing here
else ifeq ($(BR2_TOOLCHAIN_EXTERNAL_GCC_9),y)
LIBMODLA_SOURCE_EXTRA_SUFFIX = -gcc9
else ifeq ($(BR2_SHARED_STATIC_LIBS),y)
LIBMODLA_SOURCE_EXTRA_SUFFIX = -gcc7
endif

LIBMODLA_VERSION = v1.3.1
LIBMODLA_SITE = https://download.mod.audio/shared
LIBMODLA_SOURCE = libmodla-$(LIBMODLA_VERSION)-$(LIBMODLA_SOURCE_SUFFIX)$(LIBMODLA_SOURCE_EXTRA_SUFFIX).tar.gz
LIBMODLA_INSTALL_STAGING = YES

define LIBMODLA_INSTALL_STAGING_CMDS
	(cd $(@D); install -m 644 mod-license.h libmodla.h $(STAGING_DIR)/usr/include)
	(cd $(@D); install -m 644 libmodla.a $(STAGING_DIR)/usr/lib)
endef

$(eval $(generic-package))
