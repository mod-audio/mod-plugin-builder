################################################################################
#
# libpd
#
################################################################################

LIBPD_VERSION = 019f864802cebc531f425ba6d1be8fd49f630a3e
LIBPD_SITE = $(call github,libpd,libpd,$(LIBPD_VERSION))
LIBPD_INSTALL_STAGING = YES

LIBPD_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) UTIL=true EXTRA=true JAVA_HOME=. -C $(@D)

# needed for git submodules
define LIBPD_EXTRACT_CMDS
	rm -rf $(@D)
	git clone --recursive git://github.com/libpd/libpd $(@D)
	(cd $(@D) && \
		git reset --hard $(LIBPD_VERSION) && \
		git submodule update)
	touch $(@D)/.stamp_downloaded
endef

define LIBPD_BUILD_CMDS
	$(LIBPD_TARGET_MAKE)
endef

define LIBPD_INSTALL_TARGET_CMDS
	$(LIBPD_TARGET_MAKE) install prefix=$(TARGET_DIR)/usr
endef

define LIBPD_INSTALL_STAGING_CMDS
	$(LIBPD_TARGET_MAKE) install prefix=$(STAGING_DIR)/usr
endef

$(eval $(generic-package))
