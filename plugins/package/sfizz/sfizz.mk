######################################
#
# sfizz
#
######################################

SFIZZ_VERSION = 930bfdfefed49d44d0c1f547da4d8c637e63155d
SFIZZ_SITE = $(call github,sfztools,sfizz,$(SFIZZ_VERSION))
SFIZZ_DEPENDENCIES = libsndfile
SFIZZ_CONF_OPTS=-DSFIZZ_JACK=OFF
SFIZZ_BUNDLES = sfizz.lv2

# needed for git submodules
define SFIZZ_EXTRACT_CMDS
	rm -rf $(@D)
	git clone --recursive git://github.com/sfztools/sfizz $(@D)
	(cd $(@D) && \
		git reset --hard $(SFIZZ_VERSION) && \
		git submodule update)
	touch $(@D)/.stamp_downloaded
endef

# define SFIZZ_POST_INSTALL_TARGET_TTLFILES
# 	cp -rL $($(PKG)_PKGDIR)/sfizz.lv2/* $(TARGET_DIR)/usr/lib/lv2/sfizz.lv2/
# endef

# SFIZZ_POST_INSTALL_TARGET_HOOKS += SFIZZ_POST_INSTALL_TARGET_TTLFILES

$(eval $(cmake-package))
