######################################
#
# mod-cv-plugins
#
######################################

LOGIC_OPERATORS_VERSION = d3b86ab7aedb388c48ee9ae765ac77b8309646b2
LOGIC_OPERATORS_SITE = $(call github,moddevices,mod-cv-plugins,$(LOGIC_OPERATORS_VERSION))
LOGIC_OPERATORS_BUNDLES = cv-logic-equal.lv2 cv-logic-larger.lv2 cv-logic-or.lv2 cv-logic-smaller.lv2 cv-logic-change.lv2

# dependencies (list of other buildroot packages, separated by space)
LOGIC_OPERATORS_DEPENDENCIES =

# call make with the current arguments and path. "$(@D)" is the build directory.
LOGIC_OPERATORS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)/logic-operators

define LOGIC_OPERATORS_BUILD_CMDS
	$(LOGIC_OPERATORS_TARGET_MAKE)
endef

define LOGIC_OPERATORS_INSTALL_TARGET_CMDS
	install -d $(TARGET_DIR)/usr/lib/lv2/
	cp -r $(@D)/logic-operators/*/source/*.lv2  $(TARGET_DIR)/usr/lib/lv2/
endef

$(eval $(generic-package))
