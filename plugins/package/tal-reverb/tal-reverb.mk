######################################
#
# tal-reverb
#
######################################

TAL_REVERB_VERSION = 58485ff6b7559f3a470e9924ab0074bae163ea63
TAL_REVERB_SITE = $(call github,DISTRHO,DISTRHO-Ports,$(TAL_REVERB_VERSION))
TAL_REVERB_BUNDLES = TAL-Reverb-2.lv2

TAL_REVERB_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) LINUX_EMBED=true -C $(@D)

define TAL_REVERB_CONFIGURE_CMDS
       (cd $(@D); LINUX_EMBED=1 ./scripts/premake-update.sh linux)
endef

define TAL_REVERB_BUILD_CMDS
	$(TAL_REVERB_TARGET_MAKE) lv2_nogen
endef

define TAL_REVERB_INSTALL_TARGET_CMDS
	install -d $(TARGET_DIR)/usr/lib/lv2/
	cp -r $(@D)/bin/lv2/TAL-Reverb-2.lv2/        $(TARGET_DIR)/usr/lib/lv2/mod-tal-Reverb-2.lv2
	cp -rL $($(PKG)_PKGDIR)/mod-tal-Reverb-2.lv2 $(TARGET_DIR)/usr/lib/lv2/
endef

$(eval $(generic-package))
