######################################
#
# ykchorus-labs
#
######################################

YKCHORUS_LABS_VERSION = ad792b60b3aa710836cabc513991899738659dde
YKCHORUS_LABS_SITE = $(call github,SpotlightKid,ykchorus,$(YKCHORUS_LABS_VERSION))
YKCHORUS_LABS_BUNDLES = ykchorus.lv2

YKCHORUS_LABS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) NOOPT=true -C $(@D)

# needed for git submodules
define YKCHORUS_LABS_EXTRACT_CMDS
	rm -rf $(@D)
	git clone --recursive https://github.com/SpotlightKid/ykchorus.git $(@D)
	(cd $(@D) && \
		git reset --hard $(YKCHORUS_LABS_VERSION) && \
		git submodule update)
	# FIXME: remove next 2 lines when upstream updates its dpf version
	(cd $(@D)/dpf && \
		git reset --hard a40eafdf187d6cba5ec68a2d1a3b4ced44b22361)
	touch $(@D)/.stamp_downloaded
endef

define YKCHORUS_LABS_BUILD_CMDS
	$(YKCHORUS_LABS_TARGET_MAKE)
endef

define YKCHORUS_LABS_INSTALL_TARGET_CMDS
	$(YKCHORUS_LABS_TARGET_MAKE) install PREFIX=/usr DESTDIR=$(TARGET_DIR)
endef

$(eval $(generic-package))
