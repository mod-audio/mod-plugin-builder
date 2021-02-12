######################################
#
# notes-lv2
#
######################################

NOTES_LV2_VERSION = 0.2.0
NOTES_LV2_SITE = https://git.open-music-kontrollers.ch/lv2/notes.lv2/snapshot
NOTES_LV2_SOURCE = notes.lv2-$(NOTES_LV2_VERSION).tar.xz
NOTES_LV2_DEPENDENCIES = lv2
NOTES_LV2_BUNDLES = notes.lv2

NOTES_LV2_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)

define NOTES_LV2_BUILD_CMDS
	cp $($(PKG)_PKGDIR)/Makefile $(@D)/Makefile
	$(NOTES_LV2_TARGET_MAKE)
endef

define NOTES_LV2_INSTALL_TARGET_CMDS
	$(NOTES_LV2_TARGET_MAKE) install DESTDIR=$(TARGET_DIR)
	cp -rL $($(PKG)_PKGDIR)/notes.lv2/* $(TARGET_DIR)/usr/lib/lv2/notes.lv2/
endef

$(eval $(generic-package))
