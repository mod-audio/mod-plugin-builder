######################################
#
# sfizz-labs
#
######################################

SFIZZ_LABS_VERSION = a1cef9ba16c2c6603e1c7611932b61a701cc7647
SFIZZ_LABS_SITE = $(call github,sfztools,sfizz,$(SFIZZ_LABS_VERSION))
SFIZZ_LABS_DEPENDENCIES = host-cmake
SFIZZ_LABS_CONF_OPTS  = -DSFIZZ_JACK=OFF
SFIZZ_LABS_CONF_OPTS += -DSFIZZ_RENDER=OFF
SFIZZ_LABS_CONF_OPTS += -DSFIZZ_LV2_UI=OFF
SFIZZ_LABS_CONF_OPTS += -DSFIZZ_VST=OFF
SFIZZ_LABS_CONF_OPTS += -DSFIZZ_SHARED=OFF
SFIZZ_LABS_CONF_OPTS += -DBUILD_SHARED_LIBS=FALSE
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
