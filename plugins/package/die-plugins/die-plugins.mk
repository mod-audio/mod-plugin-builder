######################################
#
# die-plugins
#
######################################

DIE_PLUGINS_VERSION = ed17dc97153f93c3b38ee2f8a5c66b02678c1fdb
DIE_PLUGINS_SITE = $(call github,DISTRHO,DIE-Plugins,$(DIE_PLUGINS_VERSION))
DIE_PLUGINS_DEPENDENCIES = fluidsynth libsndfile
DIE_PLUGINS_BUNDLES = distrho-a-fluidsynth.lv2

DIE_PLUGINS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) DISABLE_OPENMP=1 -C $(@D)

define DIE_PLUGINS_BUILD_CMDS
	$(DIE_PLUGINS_TARGET_MAKE)
endef

define DIE_PLUGINS_INSTALL_TARGET_CMDS
	$(DIE_PLUGINS_TARGET_MAKE) install PREFIX=/usr DESTDIR=$(TARGET_DIR)
	cp -rL $($(PKG)_PKGDIR)/distrho-a-fluidsynth.lv2/* $(TARGET_DIR)/usr/lib/lv2/distrho-a-fluidsynth.lv2/
endef

$(eval $(generic-package))
