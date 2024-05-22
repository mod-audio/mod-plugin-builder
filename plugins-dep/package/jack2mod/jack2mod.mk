################################################################################
#
# jack2
#
################################################################################

JACK2MOD_VERSION = 2ecce1fe4ec1965fc31f2487b97bcb680db5b191
JACK2MOD_SITE = $(call github,jackaudio,jack2,$(JACK2MOD_VERSION))
JACK2MOD_LICENSE = GPLv2+ (jack server), LGPLv2.1+ (jack library)
JACK2MOD_DEPENDENCIES = libsamplerate libsndfile alsa-lib host-python3
JACK2MOD_INSTALL_STAGING = YES

ifeq ($(BR2_VERSION),2016.02)
JACK2MOD_DEPENDENCIES += opus-custom
else
JACK2MOD_DEPENDENCIES += opus
endif

JACK2MOD_WAF = $(HOST_DIR)/usr/bin/python3 ./waf

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
