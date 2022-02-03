######################################
#
# guitarix-gxtuner
#
######################################

GUITARIX_GXTUNER_VERSION = 0.43.1
GUITARIX_GXTUNER_SITE = http://download.sourceforge.net/guitarix/
GUITARIX_GXTUNER_SOURCE = guitarix2-$(GUITARIX_GXTUNER_VERSION).tar.xz
GUITARIX_GXTUNER_DEPENDENCIES = boost eigen fftw-single glibmm libsndfile host-python host-intltool
GUITARIX_GXTUNER_BUNDLES = gxtuner.lv2

GUITARIX_GXTUNER_TARGET_WAF = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) EIGEN3_PATH=$(STAGING_DIR)/usr/include/eigen3/ $(HOST_DIR)/usr/bin/python2 ./waf

define GUITARIX_GXTUNER_CONFIGURE_CMDS
	(cd $(@D); $(GUITARIX_GXTUNER_TARGET_WAF) configure --prefix=/usr --convolver-ffmpeg --disable-sse --no-ldconfig --no-lv2-gui --no-faust)
endef

define GUITARIX_GXTUNER_BUILD_CMDS
	(cd $(@D); $(GUITARIX_GXTUNER_TARGET_WAF) build -j $(PARALLEL_JOBS))
endef

define GUITARIX_GXTUNER_INSTALL_TARGET_CMDS
	# install to temp dir
	(cd $(@D); $(GUITARIX_GXTUNER_TARGET_WAF) install --destdir=$(TARGET_DIR)/guitarix)
	
	# move out gxtuner
	mv $(TARGET_DIR)/guitarix/gxtuner.lv2 $(TARGET_DIR)/usr/lib/lv2/

	# delete everything else
	rm -rf $(TARGET_DIR)/guitarix
endef

$(eval $(generic-package))
