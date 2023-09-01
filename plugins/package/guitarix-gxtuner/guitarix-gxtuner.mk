######################################
#
# guitarix-gxtuner
#
######################################

GUITARIX_GXTUNER_VERSION = 056c2577c0e77367a09cd1ef18e219056920c1d8
GUITARIX_GXTUNER_SITE = $(call github,brummer10,guitarix,$(GUITARIX_GXTUNER_VERSION))
GUITARIX_GXTUNER_DEPENDENCIES = boost eigen ffmpeg fftw-single glibmm libsndfile host-python host-intltool
GUITARIX_GXTUNER_BUNDLES = gxtuner.lv2

GUITARIX_GXTUNER_TARGET_WAF = \
	$(TARGET_MAKE_ENV) \
	$(TARGET_CONFIGURE_OPTS) \
	EIGEN3_PATH=$(STAGING_DIR)/usr/include/eigen3/ \
	$(HOST_DIR)/usr/bin/python ./waf

define GUITARIX_GXTUNER_CONFIGURE_CMDS
	(cd $(@D)/trunk; $(GUITARIX_GXTUNER_TARGET_WAF) configure \
		--prefix=/usr \
		--convolver-ffmpeg \
		--disable-sse \
		--no-faust \
		--no-ldconfig \
		--no-lv2-gui \
		--no-standalone \
	)
endef

define GUITARIX_GXTUNER_BUILD_CMDS
	(cd $(@D)/trunk; $(GUITARIX_GXTUNER_TARGET_WAF) build -j $(PARALLEL_JOBS))
endef

define GUITARIX_GXTUNER_INSTALL_TARGET_CMDS
	# install to temp dir
	(cd $(@D)/trunk; $(GUITARIX_GXTUNER_TARGET_WAF) install --destdir=$(TARGET_DIR)/guitarix)

	# move out gxtuner
	rm -rf $(TARGET_DIR)/usr/lib/lv2/gxtuner.lv2
	mv $(TARGET_DIR)/guitarix/usr/lib/lv2/gxtuner.lv2 $(TARGET_DIR)/usr/lib/lv2/

	# delete everything else
	rm -rf $(TARGET_DIR)/guitarix
endef

$(eval $(generic-package))
