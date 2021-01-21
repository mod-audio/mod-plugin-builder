######################################
#
# mod-tal-noisemaker
#
######################################

MOD_TAL_NOISEMAKER_VERSION = cb71b646f1908e0cdfd1ad4c1e23c6bf1357c25d
MOD_TAL_NOISEMAKER_SITE = $(call github,moddevices,mod-tal-noisemaker,$(MOD_TAL_NOISEMAKER_VERSION))
MOD_TAL_NOISEMAKER_BUNDLES = TAL-NoiseMaker-ME.lv2

# dependencies (list of other buildroot packages, separated by space)
MOD_TAL_NOISEMAKER_DEPENDENCIES =

# call make with the current arguments and path. "$(@D)" is the build directory.
MOD_TAL_NOISEMAKER_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) LINUX_EMBED=true -C $(@D)

ifdef BR2_cortex_a7
DUO_V=
else
DUO_V=DUOX=1
endif

define MOD_TAL_NOISEMAKER_CONFIGURE_CMDS
       (cd $(@D); LINUX_EMBED=1 $(DUO_V) ./scripts/premake-update.sh linux)
endef

define MOD_TAL_NOISEMAKER_BUILD_CMDS
	$(MOD_TAL_NOISEMAKER_TARGET_MAKE) lv2_nogen
endef

define MOD_TAL_NOISEMAKER_INSTALL_TARGET_CMDS
	install -d $(TARGET_DIR)/usr/lib/lv2/
	cp -r $(@D)/bin/lv2/*.lv2/ $(TARGET_DIR)/usr/lib/lv2/
	cp -r $(@D)/data/*         $(TARGET_DIR)/usr/lib/lv2/TAL-NoiseMaker-ME.lv2/
endef

$(eval $(generic-package))
