######################################
#
# max-gen-zwabo
#
######################################

MAX_GEN_ZWABO_VERSION = 32ca3299ac30c89f67af971d46de5d1563d17c89
MAX_GEN_ZWABO_SITE = https://github.com/mod-audio/max-gen-plugins.git
MAX_GEN_ZWABO_SITE_METHOD = git
MAX_GEN_ZWABO_BUNDLES = zwabo-cozmic.lv2 zwabo-mirrorz.lv2 zwabo-stuttter.lv2 zwabo-toggle_2in.lv2 zwabo-xfade1to2st.lv2 zwabo-zinvert_phase.lv2 zwabo-ztoggle4.lv2

# needed for submodules support
MAX_GEN_ZWABO_PRE_DOWNLOAD_HOOKS += MOD_PLUGIN_BUILDER_DOWNLOAD_WITH_SUBMODULES

# build at -O2 like the upstream Makefile: with buildroot's -O3, GCC vectorises genlib's buffer clear and adding
# MIRRORZz (2x 7.2M-frame buffers) causes 5-7 xruns on the Dwarf; -O2 gives none, same DSP load
MAX_GEN_ZWABO_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) CFLAGS="$(TARGET_CFLAGS) -O2" CXXFLAGS="$(TARGET_CXXFLAGS) -O2" $(MAKE) NOOPT=true -C $(@D)

define MAX_GEN_ZWABO_BUILD_CMDS
	$(MAX_GEN_ZWABO_TARGET_MAKE)
endef

define MAX_GEN_ZWABO_INSTALL_TARGET_CMDS
	install -d $(TARGET_DIR)/usr/lib/lv2
	cp -r $(@D)/bin/*.lv2 $(TARGET_DIR)/usr/lib/lv2/
endef

$(eval $(generic-package))
