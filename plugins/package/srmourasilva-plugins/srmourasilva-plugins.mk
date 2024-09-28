######################################
#
# SrMouraSilva Plugins
#
######################################
SRMOURASILVA_PLUGINS_VERSION = 1d37ffa

SRMOURASILVA_PLUGINS_SITE_METHOD = git
SRMOURASILVA_PLUGINS_SITE = https://github.com/SrMouraSilva/plugins-lv2.git
SRMOURASILVA_PLUGINS_BUNDLES = gossiper.lv2 tetr4-switch.lv2 
SRMOURASILVA_PLUGINS_CONF_ENV = DESTDIR="$(TARGET_DIR)"

SRMOURASILVA_PLUGINS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)/plugins

# build command
define SRMOURASILVA_PLUGINS_BUILD_CMDS
	$(SRMOURASILVA_PLUGINS_TARGET_MAKE)
endef

# install command
define SRMOURASILVA_PLUGINS_INSTALL_TARGET_CMDS
	$(SRMOURASILVA_PLUGINS_TARGET_MAKE) install DESTDIR=$(TARGET_DIR)
endef


# import everything else from the buildroot generic package
$(eval $(generic-package))
