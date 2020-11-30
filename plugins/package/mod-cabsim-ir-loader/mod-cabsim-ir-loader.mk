######################################
#
# cabsim-IR-loader
#
######################################

MOD_CABSIM_IR_LOADER_VERSION = c431e3a2417befe563658f52f3cf8a3ff1e228ca
MOD_CABSIM_IR_LOADER_SITE = $(call github,moddevices,mod-cabsim-IR-loader,$(MOD_CABSIM_IR_LOADER_VERSION))

MOD_CABSIM_IR_LOADER_BUNDLES = cabsim-IR-loader.lv2

MOD_CABSIM_IR_LOADER_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)/source

define MOD_CABSIM_IR_LOADER_BUILD_CMDS
	$(MOD_CABSIM_IR_LOADER_TARGET_MAKE)
endef

define MOD_CABSIM_IR_LOADER_INSTALL_TARGET_CMDS
	$(MOD_CABSIM_IR_LOADER_TARGET_MAKE) install DESTDIR=$(TARGET_DIR)
endef

$(eval $(generic-package))
