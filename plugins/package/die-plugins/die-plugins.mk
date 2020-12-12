######################################
#
# die-plugins
#
######################################

DIE_PLUGINS_VERSION = 54052b9ca309250943cdf7b15b5afec2f72a9ce6
DIE_PLUGINS_SITE = $(call github,DISTRHO,DIE-Plugins,$(DIE_PLUGINS_VERSION))
DIE_PLUGINS_DEPENDENCIES = fluidsynth libsndfile
DIE_PLUGINS_BUNDLES = distrho-a-fluidsynth.lv2

DIE_PLUGINS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)

define DIE_PLUGINS_BUILD_CMDS
	$(DIE_PLUGINS_TARGET_MAKE)
endef

define DIE_PLUGINS_INSTALL_TARGET_CMDS
	$(DIE_PLUGINS_TARGET_MAKE) install PREFIX=/usr DESTDIR=$(TARGET_DIR)
endef

$(eval $(generic-package))
