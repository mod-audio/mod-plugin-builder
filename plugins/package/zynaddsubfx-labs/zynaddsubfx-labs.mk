######################################
#
# zynaddsubfx-labs
#
######################################

# v3.0.5
ZYNADDSUBFX_LABS_VERSION = 4d4aedf834dbd13c6e5f07ac512c9da74732fd58
ZYNADDSUBFX_LABS_SITE = git://git.code.sf.net/p/zynaddsubfx/code
ZYNADDSUBFX_LABS_SITE_METHOD = git
ZYNADDSUBFX_LABS_DEPENDENCIES = fftw-single fftw-double mxml liblo zlib
ZYNADDSUBFX_LABS_BUNDLES = ZynAddSubFX.lv2 ZynAlienWah.lv2 ZynChorus.lv2 ZynDistortion.lv2 ZynDynamicFilter.lv2 ZynEcho.lv2 ZynPhaser.lv2 ZynReverb.lv2

ZYNADDSUBFX_LABS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) VERBOSE=1 -C $(@D)

# needed for git submodules
define ZYNADDSUBFX_LABS_EXTRACT_CMDS
	rm -rf $(@D)
	git clone --recursive $(ZYNADDSUBFX_LABS_SITE) $(@D)
	(cd $(@D) && \
		git reset --hard $(ZYNADDSUBFX_LABS_VERSION) && \
		git submodule update)
	touch $(@D)/.stamp_downloaded
endef

define ZYNADDSUBFX_LABS_BUILD_CMDS
	$(ZYNADDSUBFX_LABS_TARGET_MAKE)
endef

define ZYNADDSUBFX_LABS_POST_INSTALL_TARGET_MODGUIS
	# presets (clear all first)
	rm $(TARGET_DIR)/usr/lib/lv2/ZynAddSubFX.lv2/*.ttl
	cp -L $($(PKG)_PKGDIR)/ZynAddSubFX.lv2/*.ttl $(TARGET_DIR)/usr/lib/lv2/ZynAddSubFX.lv2/

	# modguis
	cp -rL $($(PKG)_PKGDIR)/ZynAddSubFX.lv2/modgui $(TARGET_DIR)/usr/lib/lv2/ZynAddSubFX.lv2/
endef

ZYNADDSUBFX_LABS_POST_INSTALL_TARGET_HOOKS += ZYNADDSUBFX_LABS_POST_INSTALL_TARGET_MODGUIS

$(eval $(cmake-package))
