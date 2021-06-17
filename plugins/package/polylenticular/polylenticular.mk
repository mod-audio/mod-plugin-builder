######################################
#
# polylenticular
#
######################################

POLYLENTICULAR_VERSION = 2621569b2b9325f48fcb13ccc515e4d2f20befb5
POLYLENTICULAR_SITE = $(call github,polyeffects,lenticular_lv2,$(POLYLENTICULAR_VERSION))
POLYLENTICULAR_BUNDLES = polylenticular.lv2
POLYLENTICULAR_CXXFLAGS = -std=c++11
POLYLENTICULAR_TARGET_MAKE =  $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) CFLAGS="$(TARGET_CFLAGS) -std=c++11" -C $(@D)

# needed for git submodules
define POLYLENTICULAR_EXTRACT_CMDS
    rm -rf $(@D)
    git clone --recursive git://github.com/polyeffects/lenticular_lv2 $(@D)
    (cd $(@D) && \
        git reset --hard $(POLYLENTICULAR_VERSION) && \
        git submodule update)
    touch $(@D)/.stamp_downloaded
endef

define POLYLENTICULAR_BUILD_CMDS
    $(POLYLENTICULAR_TARGET_MAKE)
endef

define POLYLENTICULAR_INSTALL_TARGET_CMDS
    $(POLYLENTICULAR_TARGET_MAKE) install PREFIX=/usr DESTDIR=$(TARGET_DIR)
    cp -rL $($(PKG)_PKGDIR)/polylenticular.lv2/*             $(TARGET_DIR)/usr/lib/lv2/polylenticular.lv2/
endef

$(eval $(generic-package))

