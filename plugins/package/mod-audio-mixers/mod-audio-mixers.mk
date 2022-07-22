######################################
#
# mod-audio-mixers
#
######################################

MOD_AUDIO_MIXERS_VERSION = 80367aa5a2ddacb19dbd85ca14123ed48fdbac6c
MOD_AUDIO_MIXERS_SITE = $(call github,moddevices,mod-audio-mixer-lv2,$(MOD_AUDIO_MIXERS_VERSION))
MOD_AUDIO_MIXERS_BUNDLES = mod-mixer.lv2 mod-mixer-stereo.lv2

MOD_AUDIO_MIXERS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)

# needed for git submodules
define MOD_AUDIO_MIXERS_EXTRACT_CMDS
	rm -rf $(@D)
	git clone --recursive https://github.com/moddevices/mod-audio-mixer-lv2.git $(@D)
	(cd $(@D) && \
		git reset --hard $(MOD_AUDIO_MIXERS_VERSION) && \
		git submodule update)
	touch $(@D)/.stamp_downloaded
endef

define MOD_AUDIO_MIXERS_BUILD_CMDS
	$(MOD_AUDIO_MIXERS_TARGET_MAKE)
endef

define MOD_AUDIO_MIXERS_INSTALL_TARGET_CMDS
	$(MOD_AUDIO_MIXERS_TARGET_MAKE) install PREFIX=/usr DESTDIR=$(TARGET_DIR)
	cp -rL $($(PKG)_PKGDIR)/mod-mixer.lv2/*       $(TARGET_DIR)/usr/lib/lv2/mod-mixer.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-mixer-stereo.lv2/*       $(TARGET_DIR)/usr/lib/lv2/mod-mixer-stereo.lv2/
endef

$(eval $(generic-package))
