######################################
#
# rezonateur
#
######################################

REZONATEUR_VERSION = 82b731344a961e210c27107786d0c7a4787f77cc
REZONATEUR_SITE = $(call github,jpcima,rezonateur,$(REZONATEUR_VERSION))
REZONATEUR_BUNDLES = rezonateur.lv2 rezonateur-stereo.lv2

REZONATEUR_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) HAVE_CAIRO=false HAVE_GL=false NOOPT=true -C $(@D)

# needed for git submodules
define REZONATEUR_EXTRACT_CMDS
	rm -rf $(@D)
	git clone --recursive https://github.com/jpcima/rezonateur.git $(@D)
	(cd $(@D) && \
		git reset --hard $(REZONATEUR_VERSION) && \
		git submodule update)
	touch $(@D)/.stamp_downloaded
endef

define REZONATEUR_BUILD_CMDS
	$(REZONATEUR_TARGET_MAKE)
endef

define REZONATEUR_INSTALL_TARGET_CMDS
	cp -r $(@D)/bin/*.lv2 $(TARGET_DIR)/usr/lib/lv2/
endef

$(eval $(generic-package))
