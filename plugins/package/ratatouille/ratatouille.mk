######################################
#
# ratatouille
#
######################################

RATATOUILLE_VERSION = 32d87ca068616cc0a65f857be73d86b57f6c6b6d
RATATOUILLE_SITE = https://github.com/brummer10/Ratatouille.lv2.git
RATATOUILLE_SITE_METHOD = git
RATATOUILLE_DEPENDENCIES = libsndfile
RATATOUILLE_BUNDLES = Ratatouille.lv2

# needed for submodules support
RATATOUILLE_PRE_DOWNLOAD_HOOKS += MOD_PLUGIN_BUILDER_DOWNLOAD_WITH_SUBMODULES

RATATOUILLE_SSE_CFLAGS += $(filter-out -funsafe-loop-optimizations,$(subst ",,$(BR2_TARGET_OPTIMIZATION)))
RATATOUILLE_SSE_CFLAGS += -fno-unsafe-loop-optimizations
RATATOUILLE_SSE_CFLAGS += -fsingle-precision-constant

RATATOUILLE_TARGET_STRIP = $(HOST_DIR)/usr/bin/$(BR2_TOOLCHAIN_EXTERNAL_CUSTOM_PREFIX)-strip
RATATOUILLE_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) STRIP=$(RATATOUILLE_TARGET_STRIP) SSE_CFLAGS="$(RATATOUILLE_SSE_CFLAGS)" -C $(@D)

define RATATOUILLE_BUILD_CMDS
	$(RATATOUILLE_TARGET_MAKE) mod
endef

define RATATOUILLE_INSTALL_TARGET_CMDS
	$(RATATOUILLE_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_DIR=/usr/lib/lv2
endef

$(eval $(generic-package))
