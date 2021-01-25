######################################
#
# mod-pitchshifter
#
######################################

MOD_PITCHSHIFTER_VERSION = 4fabd8994c8dff40886198d9641c1b734655602d
MOD_PITCHSHIFTER_SITE = $(call github,moddevices,mod-pitchshifter,$(MOD_PITCHSHIFTER_VERSION))
MOD_PITCHSHIFTER_DEPENDENCIES = armadillo fftw-single host-python host-python-mpmath
ifneq ($(BR2_arm)$(BR2_aarch64)$(BR2_x86_64),y)
MOD_PITCHSHIFTER_DEPENDENCIES += host-fftw-single
endif
MOD_PITCHSHIFTER_BUNDLES = mod-2voices.lv2 mod-capo.lv2 mod-drop.lv2 mod-harmonizer.lv2 mod-harmonizer2.lv2 mod-harmonizercs.lv2 mod-supercapo.lv2 mod-superwhammy.lv2

MOD_PITCHSHIFTER_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) NOOPT=true -C $(@D)

ifdef BR2_cortex_a35
MOD_PITCHSHIFTER_WISDOM_FILE = harmonizer.wisdom.dwarf
else ifdef BR2_cortex_a53
MOD_PITCHSHIFTER_WISDOM_FILE = harmonizer.wisdom.duox
else ifdef BR2_arm
MOD_PITCHSHIFTER_WISDOM_FILE = harmonizer.wisdom.duo
else ifdef BR2_x86_64
MOD_PITCHSHIFTER_WISDOM_FILE = harmonizer.wisdom.x86_64
endif

ifeq ($(BR2_arm)$(BR2_aarch64)$(BR2_x86_64),y)
define MOD_PITCHSHIFTER_PREBUILD_STEP
	cp $($(PKG)_PKGDIR)/$(MOD_PITCHSHIFTER_WISDOM_FILE) $(@D)/Shared_files/harmonizer.wisdom
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
