######################################
#
# master_me
#
######################################

MASTER_ME_VERSION = da3033e090372168dcda395103c84d4475491365
MASTER_ME_SITE = https://github.com/trummerschlunk/master_me.git
MASTER_ME_SITE_METHOD = git
MASTER_ME_GIT_SUBMODULES = y
MASTER_ME_BUNDLES = master_me.lv2

MASTER_ME_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) BASE_OPTS="-O3 -ffinite-math-only -fsingle-precision-constant" HAVE_DGL=false HAVE_OPENGL=false -C $(@D)

# needed for submodules support
MASTER_ME_PRE_DOWNLOAD_HOOKS += MOD_PLUGIN_BUILDER_DOWNLOAD_WITH_SUBMODULES

define MASTER_ME_BUILD_CMDS
	$(MASTER_ME_TARGET_MAKE)
endef

define MASTER_ME_INSTALL_TARGET_CMDS
	install -d $(TARGET_DIR)/usr/lib/lv2/master_me.lv2
	install -m 644 $(@D)/bin/master_me.lv2/*.* $(TARGET_DIR)/usr/lib/lv2/master_me.lv2
	cp -rL $($(PKG)_PKGDIR)/master_me.lv2/* $(TARGET_DIR)/usr/lib/lv2/master_me.lv2/
endef

$(eval $(generic-package))
