######################################
#
# mod-tal-noisemaker
#
######################################

MOD_TAL_NOISEMAKER_VERSION = 9997a474283f2f5dc1bc558704cbcdaa056d298f
MOD_TAL_NOISEMAKER_SITE = $(call github,moddevices,mod-tal-noisemaker,$(MOD_TAL_NOISEMAKER_VERSION))
MOD_TAL_NOISEMAKER_BUNDLES = TAL-NoiseMaker-ME.lv2 

# dependencies (list of other buildroot packages, separated by space)
MOD_TAL_NOISEMAKER_DEPENDENCIES =

# call make with the current arguments and path. "$(@D)" is the build directory.
#CABSIM_BASS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)/source
MOD_TAL_NOISEMAKER_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) LINUX_EMBED=true -C $(@D)

define MOD_TAL_NOISEMAKER_CONFIGURE_CMDS
       (cd $(@D); LINUX_EMBED=1 ./scripts/premake-update.sh linux)
endef

define MOD_TAL_NOISEMAKER_BUILD_CMDS
	$(MOD_TAL_NOISEMAKER_TARGET_MAKE) lv2_nogen
endef

define MOD_TAL_NOISEMAKER_INSTALL_TARGET_CMDS
	install -d $(TARGET_DIR)/usr/lib/lv2/
	cp -r $(@D)/bin/lv2/*.lv2/    $(TARGET_DIR)/usr/lib/lv2/
	cp -r $(@D)/data/*    $(TARGET_DIR)/usr/lib/lv2/TAL-NoiseMaker-ME.lv2/
endef

$(eval $(generic-package))

