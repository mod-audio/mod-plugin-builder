######################################
#
# mod-audio-mixers
#
######################################

MOD_AUDIO_MIXERS_VERSION = 80367aa5a2ddacb19dbd85ca14123ed48fdbac6c
MOD_AUDIO_MIXERS_SITE = https://github.com/moddevices/mod-audio-mixer-lv2.git
MOD_AUDIO_MIXERS_SITE_METHOD = git
MOD_AUDIO_MIXERS_BUNDLES = mod-mixer.lv2 mod-mixer-stereo.lv2

MOD_AUDIO_MIXERS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)

# needed for submodules support
MOD_AUDIO_MIXERS_PRE_DOWNLOAD_HOOKS += MOD_PLUGIN_BUILDER_DOWNLOAD_WITH_SUBMODULES

define MOD_AUDIO_MIXERS_BUILD_CMDS
	$(MOD_AUDIO_MIXERS_TARGET_MAKE)
endef

define MOD_AUDIO_MIXERS_INSTALL_TARGET_CMDS
	$(MOD_AUDIO_MIXERS_TARGET_MAKE) install PREFIX=/usr DESTDIR=$(TARGET_DIR)
	cp -rL $($(PKG)_PKGDIR)/mod-mixer.lv2/*       $(TARGET_DIR)/usr/lib/lv2/mod-mixer.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mixer-stereo.lv2/*       $(TARGET_DIR)/usr/lib/lv2/mod-mixer-stereo.lv2/
endef

$(eval $(generic-package))
