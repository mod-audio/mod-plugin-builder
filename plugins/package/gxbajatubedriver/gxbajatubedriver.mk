######################################
#
# gxbajatubedriver
#
######################################

GXBAJATUBEDRIVER_VERSION = c219ce528864d79496a8c2a047c4a4e12dfc0ff9
GXBAJATUBEDRIVER_SITE = $(call github,brummer10,GxBaJaTubeDriver.lv2,$(GXBAJATUBEDRIVER_VERSION))
GXBAJATUBEDRIVER_BUNDLES = gx_bajatubedriver.lv2

GXBAJATUBEDRIVER_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE)  SSE_CFLAGS="-O3 -mfpu=vfpv3" -C $(@D) 

define GXBAJATUBEDRIVER_BUILD_CMDS
	$(GXBAJATUBEDRIVER_TARGET_MAKE) mod
endef

define GXBAJATUBEDRIVER_INSTALL_TARGET_CMDS
	$(GXBAJATUBEDRIVER_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_DIR=/usr/lib/lv2
endef

$(eval $(generic-package))
