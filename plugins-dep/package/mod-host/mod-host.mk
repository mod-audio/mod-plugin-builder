######################################
#
# mod-host
#
######################################

MOD_HOST_VERSION = 7e1f64f94a1e5f3cb0ee5da8cad1c990c89ff8fe
MOD_HOST_SITE = $(call github,moddevices,mod-host,$(MOD_HOST_VERSION))
MOD_HOST_DEPENDENCIES = fftw fftwf jack2mod hylia lilv readline

MOD_HOST_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)

define MOD_HOST_BUILD_CMDS
	$(MOD_HOST_TARGET_MAKE)
endef

define MOD_HOST_INSTALL_TARGET_CMDS
	$(MOD_HOST_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) PREFIX=/usr
endef

$(eval $(generic-package))
