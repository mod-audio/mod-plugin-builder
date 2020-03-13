######################################
#
# sfizz
#
######################################

SFIZZ_VERSION = 48c9dbf9471fffd201ef8da83c30bf2db466a018
SFIZZ_SITE = $(call github,paulfd,sfizz,$(SFIZZ_VERSION))
SFIZZ_DEPENDENCIES = libsndfile
SFIZZ_CONF_OPTS=-DSFIZZ_JACK=OFF
SFIZZ_BUNDLES = sfizz.lv2

# needed for git submodules
define SFIZZ_EXTRACT_CMDS
	rm -rf $(@D)
	git clone --recursive git://github.com/paulfd/sfizz $(@D)
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
