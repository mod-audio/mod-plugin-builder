######################################
#
# mod-pitchshifter
#
######################################

MOD_PITCHSHIFTER_VERSION = d404edc4d79fb59ee77bb9e87ce51de050e70a88
MOD_PITCHSHIFTER_SITE = $(call github,moddevices,mod-pitchshifter,$(MOD_PITCHSHIFTER_VERSION))
MOD_PITCHSHIFTER_DEPENDENCIES = armadillo fftwf host-fftwf host-python host-python-mpmath
MOD_PITCHSHIFTER_BUNDLES = mod-2voices.lv2 mod-capo.lv2 mod-drop.lv2 mod-harmonizer.lv2 mod-harmonizer2.lv2 mod-harmonizercs.lv2 mod-supercapo.lv2 mod-superwhammy.lv2

MOD_PITCHSHIFTER_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) NOOPT=true -C $(@D)

ifdef BR2_arm
define MOD_PITCHSHIFTER_PREBUILD_STEP
	cp $($(PKG)_PKGDIR)/harmonizer.wisdom.duo $(@D)/Shared_files/harmonizer.wisdom
endef
endif

define MOD_PITCHSHIFTER_BUILD_CMDS
	$(MOD_PITCHSHIFTER_PREBUILD_STEP)
	$(MOD_PITCHSHIFTER_TARGET_MAKE)
endef

define MOD_PITCHSHIFTER_INSTALL_TARGET_CMDS
	$(MOD_PITCHSHIFTER_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_PATH=/usr/lib/lv2
	cp -rL $($(PKG)_PKGDIR)/mod-2voices.lv2/*       $(TARGET_DIR)/usr/lib/lv2/mod-2voices.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-capo.lv2/*          $(TARGET_DIR)/usr/lib/lv2/mod-capo.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-drop.lv2/*          $(TARGET_DIR)/usr/lib/lv2/mod-drop.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-harmonizer.lv2/*    $(TARGET_DIR)/usr/lib/lv2/mod-harmonizer.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-harmonizer2.lv2/*   $(TARGET_DIR)/usr/lib/lv2/mod-harmonizer2.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-harmonizercs.lv2/*  $(TARGET_DIR)/usr/lib/lv2/mod-harmonizercs.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-supercapo.lv2/*     $(TARGET_DIR)/usr/lib/lv2/mod-supercapo.lv2/
	cp -rL $($(PKG)_PKGDIR)/mod-superwhammy.lv2/*   $(TARGET_DIR)/usr/lib/lv2/mod-superwhammy.lv2/
endef

$(eval $(generic-package))
