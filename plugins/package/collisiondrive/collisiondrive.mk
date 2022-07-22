######################################
#
# CollisionDrive
#
######################################

COLLISIONDRIVE_VERSION = eaaee3833dca45b135d35061632bd398f4b39c6d
COLLISIONDRIVE_SITE = $(call github,brummer10,CollisionDrive,$(COLLISIONDRIVE_VERSION))
COLLISIONDRIVE_BUNDLES = CollisionDrive.lv2

ifdef BR2_cortex_a7
COLLISIONDRIVE_SSE_CFLAGS = -mfpu=vfpv3
endif

COLLISIONDRIVE_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE)  SSE_CFLAGS="$(COLLISIONDRIVE_SSE_CFLAGS)" -C $(@D)

define COLLISIONDRIVE_BUILD_CMDS
	$(COLLISIONDRIVE_TARGET_MAKE) mod
endef

define COLLISIONDRIVE_INSTALL_TARGET_CMDS
	$(COLLISIONDRIVE_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) INSTALL_DIR=/usr/lib/lv2
endef

$(eval $(generic-package))
