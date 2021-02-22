######################################
#
# mod-audio-to-cv-pitch
#
######################################

MOD_AUDIO_TO_CV_PITCH_VERSION = f68f34eef8fa63942de0a040537d69083b229904
MOD_AUDIO_TO_CV_PITCH_SITE = $(call github,BramGiesen,audio-to-cv-pitch-lv2,$(MOD_AUDIO_TO_CV_PITCH_VERSION))
MOD_AUDIO_TO_CV_PITCH_BUNDLES = mod-audio-to-cv-pitch.lv2

MOD_AUDIO_TO_CV_PITCH_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) NOOPT=true -C $(@D)

# needed for git submodules
define MOD_AUDIO_TO_CV_PITCH_EXTRACT_CMDS
	rm -rf $(@D)
	git clone --recursive git://github.com/BramGiesen/audio-to-cv-pitch-lv2 $(@D)
	(cd $(@D) && \
		git reset --hard $(MOD_AUDIO_TO_CV_PITCH_VERSION) && \
		git submodule update --init --recursive)
	touch $(@D)/.stamp_downloaded
endef

define MOD_AUDIO_TO_CV_PITCH_BUILD_CMDS
	$(MOD_AUDIO_TO_CV_PITCH_TARGET_MAKE)
endef

define MOD_AUDIO_TO_CV_PITCH_INSTALL_TARGET_CMDS
	cp -r $(@D)/bin/*.lv2 $(TARGET_DIR)/usr/lib/lv2/mod-audio-to-cv-pitch.lv2
	cp -rL $($(PKG)_PKGDIR)/mod-audio-to-cv-pitch.lv2/*    $(TARGET_DIR)/usr/lib/lv2/mod-audio-to-cv-pitch.lv2/
endef

$(eval $(generic-package))
