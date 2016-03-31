######################################
#
# zynaddsubfx
#
######################################

ZYNADDSUBFX_VERSION = 9ba01bb22414193e503e4f2c5fbae744f69009d8
ZYNADDSUBFX_SITE = git://git.code.sf.net/p/zynaddsubfx/code
ZYNADDSUBFX_SITE_METHOD = git
ZYNADDSUBFX_DEPENDENCIES = fftw mxml liblo zlib
ZYNADDSUBFX_BUNDLES = 

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

# build plugins in target skipping ttl generation
define ZYNADDSUBFX_BUILD_CMDS
	# first build that fails
	$(ZYNADDSUBFX_TARGET_MAKE) || true
	$(ZYNADDSUBFX_TARGET_MAKE) || true
	$(ZYNADDSUBFX_TARGET_MAKE) || true

	# create dummy generator
	rm $(@D)/src/Plugin/lv2-ttl-generator
	touch $(@D)/src/Plugin/lv2-ttl-generator
	chmod +x $(@D)/src/Plugin/lv2-ttl-generator

	# copy previously generated ttl files
	cp -rL $($(PKG)_PKGDIR)/ZynAddSubFX.lv2/*.ttl      $(@D)/src/Plugin/ZynAddSubFX/lv2/
	cp -rL $($(PKG)_PKGDIR)/ZynAlienWah.lv2/*.ttl      $(@D)/src/Plugin/AlienWah/lv2/
	cp -rL $($(PKG)_PKGDIR)/ZynChorus.lv2/*.ttl        $(@D)/src/Plugin/Chorus/lv2/
	cp -rL $($(PKG)_PKGDIR)/ZynDistortion.lv2/*.ttl    $(@D)/src/Plugin/Distortion/lv2/
	cp -rL $($(PKG)_PKGDIR)/ZynDynamicFilter.lv2/*.ttl $(@D)/src/Plugin/DynamicFilter/lv2/
	cp -rL $($(PKG)_PKGDIR)/ZynEcho.lv2/*.ttl          $(@D)/src/Plugin/Echo/lv2/
	cp -rL $($(PKG)_PKGDIR)/ZynPhaser.lv2/*.ttl        $(@D)/src/Plugin/Phaser/lv2/
	cp -rL $($(PKG)_PKGDIR)/ZynReverb.lv2/*.ttl        $(@D)/src/Plugin/Reverb/lv2/

	# final build
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
