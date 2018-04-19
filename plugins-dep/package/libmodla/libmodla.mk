######################################
#
# libmodla
#
######################################

LIBMODLA_VERSION = v1.1.0
LIBMODLA_SITE = http://web1.moddevices.com/shared/
LIBMODLA_SOURCE = libmodla-$(LIBMODLA_VERSION).tar.gz
LIBMODLA_INSTALL_STAGING = YES

define LIBMODLA_INSTALL_STAGING_CMDS
	(cd $(@D); cp mod-license.h libmodla.h $(STAGING_DIR)/usr/include)
	(cd $(@D); cp libmodla.a $(STAGING_DIR)/usr/lib)
endef

$(eval $(generic-package))
