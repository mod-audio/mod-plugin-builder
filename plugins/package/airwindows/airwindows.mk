######################################
#
# airwindows
#
######################################

AIRWINDOWS_VERSION = f175688c1b9c9285c41d1048ceef3683f32972e7
AIRWINDOWS_SITE = https://github.com/hannesbraun/airwindows-lv2.git
AIRWINDOWS_SITE_METHOD = git
AIRWINDOWS_CONF_OPTS = -DCMAKE_INSTALL_PREFIX=/usr/lib/lv2
AIRWINDOWS_BUNDLES = Airwindows.lv2

# needed for submodules support
# AIRWINDOWS_PRE_DOWNLOAD_HOOKS += MOD_PLUGIN_BUILDER_DOWNLOAD_WITH_SUBMODULES

# define AIRWINDOWS_INSTALL_TARGET_CMDS
# 	cp -rL $(@D)/$(AIRWINDOWS_SUBDIR)/airwindows.lv2 $(TARGET_DIR)/usr/lib/lv2/
# 	cp -rL $($(PKG)_PKGDIR)/airwindows.lv2/*         $(TARGET_DIR)/usr/lib/lv2/airwindows.lv2/
# endef

$(eval $(cmake-package))
