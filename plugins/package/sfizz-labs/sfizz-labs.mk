######################################
#
# sfizz-labs
#
######################################

SFIZZ_LABS_VERSION = 0160af3bb7f17c88f3f1a357eabe5281ecccefd4
SFIZZ_LABS_SITE = $(call github,sfztools,sfizz,$(SFIZZ_LABS_VERSION))
SFIZZ_LABS_DEPENDENCIES = libsndfile host-cmake
SFIZZ_LABS_CONF_OPTS=-DSFIZZ_LABS_JACK=OFF -DSFIZZ_LABS_SHARED=OFF -DABSL_BUILD_DLL=FALSE -DBUILD_SHARED_LIBS=FALSE
# -DSFIZZ_LABS_RENDER=OFF
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
