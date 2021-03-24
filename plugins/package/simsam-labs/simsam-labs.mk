######################################
#
# simsam-labs
#
######################################

SIMSAM_LABS_VERSION = 1881ed1a0fdd904de678b1a6971d8acbdcddbdcf
SIMSAM_LABS_SITE = https://gitlab.com/edwillys/simsam.git
SIMSAM_LABS_SITE_METHOD = git
SIMSAM_LABS_DEPENDENCIES = libsndfile
SIMSAM_LABS_BUNDLES = simsam.lv2

# SIMSAM_LABS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)/source
# 
# define SIMSAM_LABS_BUILD_CMDS
# 	$(SIMSAM_LABS_TARGET_MAKE)
# endef

define SIMSAM_LABS_INSTALL_TARGET_CMDS
	install -d $(TARGET_DIR)/usr/lib/lv2/simsam.lv2/modgui
	install -m 644 \
		$(@D)/simsam.so \
		$(@D)/bundles/simsam.lv2/*.ttl \
		$(TARGET_DIR)/usr/lib/lv2/simsam.lv2
	install -m 644 \
		$(@D)/bundles/simsam.lv2/modgui/*.* \
		$(TARGET_DIR)/usr/lib/lv2/simsam.lv2/modgui
endef

$(eval $(cmake-package))
