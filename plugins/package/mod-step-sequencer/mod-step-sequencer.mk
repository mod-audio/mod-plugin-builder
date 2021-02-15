######################################
#
# mod-step-sequencer
#
######################################

MOD_STEP_SEQUENCER_VERSION = 4958b4201c3291f6a36cd0c4bc52d118c53c5144
MOD_STEP_SEQUENCER_SITE = $(call github,moddevices,mod-step-sequencer-lv2,$(MOD_STEP_SEQUENCER_VERSION))
MOD_STEP_SEQUENCER_BUNDLES = mod-step-sequencer.lv2

# dependencies (list of other buildroot packages, separated by space)
MOD_STEP_SEQUENCER_DEPENDENCIES =

# call make with the current arguments and path. "$(@D)" is the build directory.
MOD_STEP_SEQUENCER_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) NOOPT=true HAVE_CAIRO=false HAVE_GL=false -C $(@D)

define MOD_STEP_SEQUENCER_BUILD_CMDS
	$(MOD_STEP_SEQUENCER_TARGET_MAKE)
endef

define MOD_STEP_SEQUENCER_INSTALL_TARGET_CMDS
	install -d $(TARGET_DIR)/usr/lib/lv2/
	cp -r $(@D)/bin/*.lv2 $(TARGET_DIR)/usr/lib/lv2/
endef

$(eval $(generic-package))
