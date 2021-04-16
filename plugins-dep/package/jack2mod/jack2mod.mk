################################################################################
#
# jack2
#
################################################################################

JACK2MOD_VERSION = 852ba2b8ebc944865e75d8eb5d4550d408772f3b
JACK2MOD_SITE = $(call github,jackaudio,jack2,$(JACK2MOD_VERSION))
JACK2MOD_LICENSE = GPLv2+ (jack server), LGPLv2.1+ (jack library)
JACK2MOD_DEPENDENCIES = libsamplerate libsndfile alsa-lib opus-custom host-python
JACK2MOD_INSTALL_STAGING = YES

JACK2MOD_WAF = $(HOST_DIR)/usr/bin/python ./waf

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
