######################################
#
# zynaddsubfx
#
######################################

ZYNADDSUBFX_VERSION = 67366a08a8362af15ea60f6fe39f4ad9918af08f
ZYNADDSUBFX_SITE = git://git.code.sf.net/p/zynaddsubfx/code
ZYNADDSUBFX_SITE_METHOD = git
ZYNADDSUBFX_DEPENDENCIES = fftw-single fftw-double mxml liblo zlib
ZYNADDSUBFX_BUNDLES = ZynAddSubFX.lv2 ZynAlienWah.lv2 ZynChorus.lv2 ZynDistortion.lv2 ZynDynamicFilter.lv2 ZynEcho.lv2 ZynPhaser.lv2 ZynReverb.lv2

ZYNADDSUBFX_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) VERBOSE=1 -C $(@D)

# needed for git submodules
define ZYNADDSUBFX_EXTRACT_CMDS
	rm -rf $(@D)
	git clone --recursive $(ZYNADDSUBFX_SITE) $(@D)
	(cd $(@D) && \
		git reset --hard $(ZYNADDSUBFX_VERSION) && \
		git submodule update)
	touch $(@D)/.stamp_downloaded
endef

define ZYNADDSUBFX_BUILD_CMDS
	$(ZYNADDSUBFX_TARGET_MAKE)
endef

define ZYNADDSUBFX_POST_INSTALL_TARGET_MODGUIS
	# presets (clear all first)
	rm $(TARGET_DIR)/usr/lib/lv2/ZynAddSubFX.lv2/*.ttl
	cp -L $($(PKG)_PKGDIR)/ZynAddSubFX.lv2/*.ttl $(TARGET_DIR)/usr/lib/lv2/ZynAddSubFX.lv2/

	# modguis
	cp -rL $($(PKG)_PKGDIR)/ZynAddSubFX.lv2/modgui $(TARGET_DIR)/usr/lib/lv2/ZynAddSubFX.lv2/
endef

ZYNADDSUBFX_POST_INSTALL_TARGET_HOOKS += ZYNADDSUBFX_POST_INSTALL_TARGET_MODGUIS

$(eval $(cmake-package))
