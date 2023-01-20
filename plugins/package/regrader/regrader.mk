######################################
#
# regrader
#
######################################

REGRADER_VERSION = 9154881ad6553537cc7f2a743541f6b47de2a207
REGRADER_SITE = https://github.com/linuxmao-org/regrader-port.git
REGRADER_SITE_METHOD = git
REGRADER_BUNDLES = regrader.lv2

# needed for submodules support
REGRADER_PRE_DOWNLOAD_HOOKS += MOD_PLUGIN_BUILDER_DOWNLOAD_WITH_SUBMODULES

REGRADER_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) HAVE_CAIRO=false MOD_BUILD=true NOOPT=true WITH_LTO=true PREFIX=/usr -C $(@D)

define REGRADER_BUILD_CMDS
	$(REGRADER_TARGET_MAKE)
endef

define REGRADER_INSTALL_TARGET_CMDS
	$(REGRADER_TARGET_MAKE) install DESTDIR=$(TARGET_DIR)
# 	cp -rL $($(PKG)_PKGDIR)/regrader.lv2/* $(TARGET_DIR)/usr/lib/lv2/regrader.lv2/
endef

$(eval $(generic-package))

