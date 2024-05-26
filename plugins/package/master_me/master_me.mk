######################################
#
# master_me
#
######################################

MASTER_ME_VERSION = 95f13d6b0a805d3dc7ad5efa79d97a824e7c48cf
MASTER_ME_SITE = https://github.com/trummerschlunk/master_me.git
MASTER_ME_SITE_METHOD = git
MASTER_ME_GIT_SUBMODULES = y
MASTER_ME_BUNDLES = master_me.lv2

MASTER_ME_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) NOOPT=true HAVE_DGL=false HAVE_OPENGL=false -C $(@D)

# needed for submodules support
MASTER_ME_PRE_DOWNLOAD_HOOKS += MOD_PLUGIN_BUILDER_DOWNLOAD_WITH_SUBMODULES

define MASTER_ME_BUILD_CMDS
	$(MASTER_ME_TARGET_MAKE)
endef

define MASTER_ME_INSTALL_TARGET_CMDS
	$(MASTER_ME_TARGET_MAKE) install PREFIX=/usr DESTDIR=$(TARGET_DIR)
	cp -rL $($(PKG)_PKGDIR)/master_me.lv2/* $(TARGET_DIR)/usr/lib/lv2/master_me.lv2/
endef

$(eval $(generic-package))
