######################################
#
# sfizz-labs
#
######################################

SFIZZ_LABS_VERSION = 1ebed26b0d6170cc29034a2b2db8093c2b1aad5c
SFIZZ_LABS_SITE = $(call github,sfztools,sfizz,$(SFIZZ_LABS_VERSION))
SFIZZ_LABS_DEPENDENCIES = libsndfile host-cmake
SFIZZ_LABS_CONF_OPTS=-DSFIZZ_JACK=OFF -DSFIZZ_LV2_UI=OFF -DSFIZZ_SHARED=OFF -DABSL_BUILD_DLL=FALSE -DBUILD_SHARED_LIBS=FALSE
# -DSFIZZ_RENDER=OFF
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
