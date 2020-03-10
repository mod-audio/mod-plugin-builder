######################################
#
# ykchorus
#
######################################

YKCHORUS_VERSION = ad792b60b3aa710836cabc513991899738659dde
YKCHORUS_SITE = $(call github,SpotlightKid,ykchorus,$(YKCHORUS_VERSION))
YKCHORUS_BUNDLES = ykchorus.lv2

YKCHORUS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) NOOPT=true -C $(@D)

# needed for git submodules
define YKCHORUS_EXTRACT_CMDS
	rm -rf $(@D)
	git clone --recursive git://github.com/SpotlightKid/ykchorus $(@D)
	(cd $(@D) && \
		git reset --hard $(YKCHORUS_VERSION) && \
		git submodule update)
	# FIXME: remove next 2 lines when upstream updates its dpf version
	(cd $(@D)/dpf && \
		git reset --hard a40eafdf187d6cba5ec68a2d1a3b4ced44b22361)
	touch $(@D)/.stamp_downloaded
endef

define YKCHORUS_BUILD_CMDS
	$(YKCHORUS_TARGET_MAKE)
endef

define YKCHORUS_INSTALL_TARGET_CMDS
	$(YKCHORUS_TARGET_MAKE) install PREFIX=/usr DESTDIR=$(TARGET_DIR)
endef

$(eval $(generic-package))
