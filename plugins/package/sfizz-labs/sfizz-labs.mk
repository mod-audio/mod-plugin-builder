######################################
#
# sfizz-labs
#
######################################

SFIZZ_LABS_VERSION = ce2170c88d8a670eddef493401cd886e26fda89f
SFIZZ_LABS_SITE = $(call github,sfztools,sfizz,$(SFIZZ_LABS_VERSION))
SFIZZ_LABS_DEPENDENCIES = libsndfile host-cmake
# ENABLE_LTO
SFIZZ_LABS_CONF_OPTS=-DSFIZZ_JACK=OFF -DSFIZZ_RENDER=OFF -DSFIZZ_LV2_UI=OFF -DSFIZZ_VST=OFF -DSFIZZ_SHARED=OFF -DBUILD_SHARED_LIBS=FALSE
# -DABSL_BUILD_DLL=FALSE
SFIZZ_LABS_BUNDLES = sfizz.lv2

# needed for git submodules
define SFIZZ_LABS_EXTRACT_CMDS
	rm -rf $(@D)
	git clone --recursive git://github.com/sfztools/sfizz $(@D)
	(cd $(@D) && \
		git reset --hard $(SFIZZ_LABS_VERSION) && \
		git submodule update)
	touch $(@D)/.stamp_downloaded
endef

# define SFIZZ_LABS_POST_INSTALL_TARGET_TTLFILES
# 	cp -rL $($(PKG)_PKGDIR)/sfizz.lv2/* $(TARGET_DIR)/usr/lib/lv2/sfizz.lv2/
# endef

# SFIZZ_LABS_POST_INSTALL_TARGET_HOOKS += SFIZZ_LABS_POST_INSTALL_TARGET_TTLFILES

$(eval $(cmake-package))
