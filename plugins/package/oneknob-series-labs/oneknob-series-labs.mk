######################################
#
# oneknob-series-labs
#
######################################

ONEKNOB_SERIES_LABS_VERSION = 60aa374f3ef4da4a8a933db61a1206c92a8e2493
ONEKNOB_SERIES_LABS_SITE = https://github.com/DISTRHO/OneKnob-Series.git
ONEKNOB_SERIES_LABS_SITE_METHOD = git
ONEKNOB_SERIES_LABS_BUNDLES = OK-AB-InputSelector.lv2 OK-AB-OutputSelector.lv2 OK-BrickwallLimiter.lv2 OK-DevilDistortion.lv2
# not working yet
# OK-Compressor.lv2

# TODO remove this define once this rule gets into cloud builders
define MOD_PLUGIN_BUILDER_DOWNLOAD_WITH_SUBMODULES
	if [ ! -e $($(PKG)_DL_DIR).tar.gz ]; then                             \
		rm -rf $(@D);                                                 \
		git clone --recursive $($(PKG)_SITE) $(@D);                   \
		git -C $(@D) reset --hard $($(PKG)_VERSION);                  \
		git -C $(@D) submodule update;                                \
		tar --exclude=".git" -czf $($(PKG)_DL_DIR).tar.gz -C $(@D) .; \
		touch $(@D)/.stamp_downloaded $(@D)/.stamp_extracted;         \
	fi
endef

# needed for submodules support
ONEKNOB_SERIES_LABS_PRE_DOWNLOAD_HOOKS += MOD_PLUGIN_BUILDER_DOWNLOAD_WITH_SUBMODULES

ONEKNOB_SERIES_LABS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) NOOPT=true HAVE_CAIRO=false HAVE_GL=false -C $(@D)

define ONEKNOB_SERIES_LABS_BUILD_CMDS
	$(ONEKNOB_SERIES_LABS_TARGET_MAKE)
endef

define ONEKNOB_SERIES_LABS_INSTALL_TARGET_CMDS
	# $(ONEKNOB_SERIES_LABS_TARGET_MAKE) install PREFIX=/usr DESTDIR=$(TARGET_DIR)
	install -d $(TARGET_DIR)/usr/lib/lv2/
	cp -r $(@D)/bin/*.lv2 $(TARGET_DIR)/usr/lib/lv2/
endef

$(eval $(generic-package))
