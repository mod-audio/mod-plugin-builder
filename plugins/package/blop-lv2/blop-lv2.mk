######################################
#
# blop-lv2
#
######################################

BLOP_LV2_VERSION = 44ff27dd355e850b9865fa50e3f32d8e24619006
BLOP_LV2_SITE = http://git.drobilla.net/blop.lv2.git
BLOP_LV2_SITE_METHOD = git
BLOP_LV2_DEPENDENCIES = host-blop-lv2 host-lv2 host-python
BLOP_LV2_BUNDLES = 

BLOP_HOST_WAF   = $(HOST_MAKE_ENV)   $(HOST_CONFIGURE_OPTS)   $(HOST_DIR)/usr/bin/python ./waf
BLOP_TARGET_WAF = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(HOST_DIR)/usr/bin/python ./waf

BLOP_LV2_TMP_WAVEGEN = $(HOST_DIR)/blop-lv2-wavegen

define HOST_BLOP_LV2_CONFIGURE_CMDS
        (cd $(@D); $(BLOP_HOST_WAF) configure --prefix=/usr)
endef

define HOST_BLOP_LV2_BUILD_CMDS
	(cd $(@D); $(BLOP_HOST_WAF) build -j $(PARALLEL_JOBS))
	# copy wavegen for target build
	cp $(@D)/build/src/wavegen $(BLOP_LV2_TMP_WAVEGEN)
endef

define BLOP_LV2_CONFIGURE_CMDS
	(cd $(@D); $(BLOP_TARGET_WAF) configure --prefix=/usr)
endef

define BLOP_LV2_BUILD_CMDS
	# initial build that fails
	(cd $(@D); $(BLOP_TARGET_WAF) build -j $(PARALLEL_JOBS) || true)

	# copy host wavegen
	mkdir -p $(@D)/build/src
	cp $(BLOP_LV2_TMP_WAVEGEN) $(@D)/build/src/wavegen

	# now fully build
	(cd $(@D); $(BLOP_TARGET_WAF) build -j $(PARALLEL_JOBS))

	# cleanup
	rm $(BLOP_LV2_TMP_WAVEGEN)
endef

define BLOP_LV2_INSTALL_TARGET_CMDS
	(cd $(@D); $(BLOP_TARGET_WAF) install --destdir=$(TARGET_DIR))
	cp -rL $($(PKG)_PKGDIR)/blop.lv2/* $(TARGET_DIR)/usr/lib/lv2/blop.lv2/
endef

$(eval $(generic-package))
$(eval $(host-generic-package))
