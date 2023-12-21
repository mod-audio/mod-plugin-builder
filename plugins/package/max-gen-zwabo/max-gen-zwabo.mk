######################################
#
# max-gen-zwabo
#
######################################

MAX_GEN_ZWABO_VERSION = 36db05fb771287510a8143280630667876e6771e
MAX_GEN_ZWABO_SITE = https://github.com/moddevices/max-gen-plugins.git
MAX_GEN_ZWABO_SITE_METHOD = git
MAX_GEN_ZWABO_BUNDLES = zwabo-cozmic.lv2 zwabo-mirrorz.lv2 zwabo-stuttter.lv2 zwabo-toggle_2in.lv2 zwabo-xfade1to2st.lv2 zwabo-zinvert_phase.lv2 zwabo-ztoggle4.lv2

# needed for submodules support
MAX_GEN_ZWABO_PRE_DOWNLOAD_HOOKS += MOD_PLUGIN_BUILDER_DOWNLOAD_WITH_SUBMODULES

MAX_GEN_ZWABO_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) NOOPT=true -C $(@D)

define MAX_GEN_ZWABO_BUILD_CMDS
	$(MAX_GEN_ZWABO_TARGET_MAKE)
endef

define MAX_GEN_ZWABO_INSTALL_TARGET_CMDS
	install -d $(TARGET_DIR)/usr/lib/lv2
	cp -r $(@D)/bin/*.lv2 $(TARGET_DIR)/usr/lib/lv2/
endef

$(eval $(generic-package))
