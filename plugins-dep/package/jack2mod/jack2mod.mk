################################################################################
#
# jack2
#
################################################################################

JACK2MOD_VERSION = e94138b13797d0054985337d262abd5908d16b14
JACK2MOD_SITE = $(call github,moddevices,jack2,$(JACK2MOD_VERSION))
JACK2MOD_LICENSE = GPLv2+ (jack server), LGPLv2.1+ (jack library)
JACK2MOD_DEPENDENCIES = libsamplerate libsndfile alsa-lib host-python
JACK2MOD_INSTALL_STAGING = YES

JACK2MOD_WAF = $(HOST_DIR)/usr/bin/python2 ./waf

ifeq ($(BR2_cortex_a7),y)
JACK2MOD_EXTRA_FLAGS = -fprefetch-loop-arrays -funroll-loops -funsafe-loop-optimizations
endif
ifeq ($(BR2_cortex_a53),y)
JACK2MOD_EXTRA_OPTIONS = --clients=128 --ports-per-application=1024
endif

define JACK2MOD_CONFIGURE_CMDS
	(cd $(@D); \
		$(TARGET_CONFIGURE_OPTS) \
		CFLAGS="$(TARGET_CFLAGS) -ffast-math $(JACK2MOD_EXTRA_FLAGS)" \
		CXXFLAGS="$(TARGET_CXXFLAGS) -ffast-math $(JACK2MOD_EXTRA_FLAGS)" \
		LDFLAGS="$(TARGET_LDFLAGS) -Wl,--as-needed" \
		$(JACK2MOD_WAF) configure \
		--alsa    \
		--classic \
		--prefix=/usr \
		$(JACK2MOD_EXTRA_OPTIONS) \
	)
endef

define JACK2MOD_BUILD_CMDS
	(cd $(@D); $(JACK2MOD_WAF) build -j $(PARALLEL_JOBS))
endef

define JACK2MOD_INSTALL_TARGET_CMDS
	(cd $(@D); $(JACK2MOD_WAF) install --destdir=$(TARGET_DIR))
endef

define JACK2MOD_INSTALL_STAGING_CMDS
	(cd $(@D); $(JACK2MOD_WAF) install --destdir=$(STAGING_DIR))
endef

$(eval $(generic-package))
