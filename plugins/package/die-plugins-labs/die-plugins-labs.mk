######################################
#
# die-plugins-labs
#
######################################

DIE_PLUGINS_LABS_VERSION = 02a46ecc88afc0f255b9a56363cd44d5f6dc27c5
DIE_PLUGINS_LABS_SITE = $(call github,DISTRHO,DIE-Plugins,$(DIE_PLUGINS_LABS_VERSION))
DIE_PLUGINS_LABS_DEPENDENCIES = fluidsynth libsndfile
DIE_PLUGINS_LABS_BUNDLES = distrho-a-comp.lv2 distrho-a-delay.lv2 distrho-a-eq.lv2 distrho-a-exp.lv2 distrho-a-reverb.lv2

DIE_PLUGINS_LABS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) DISABLE_OPENMP=1 -C $(@D)

define DIE_PLUGINS_LABS_BUILD_CMDS
	$(DIE_PLUGINS_LABS_TARGET_MAKE)
endef

define DIE_PLUGINS_LABS_INSTALL_TARGET_CMDS
	$(DIE_PLUGINS_LABS_TARGET_MAKE) install PREFIX=/usr DESTDIR=$(TARGET_DIR)
endef

$(eval $(generic-package))
