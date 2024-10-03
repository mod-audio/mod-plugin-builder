######################################
#
# wstd-dlay
#
######################################

WSTD_DLAY_VERSION = ed9db523859437cba61d05d3fd08fd579a4a4992
WSTD_DLAY_SITE = https://github.com/Wasted-Audio/wstd-dlay.git
WSTD_DLAY_SITE_METHOD = git
WSTD_DLAY_GIT_SUBMODULES = y
WSTD_DLAY_BUNDLES = WSTD_DLAY.lv2

# needed for submodules support
WSTD_DLAY_PRE_DOWNLOAD_HOOKS += MOD_PLUGIN_BUILDER_DOWNLOAD_WITH_SUBMODULES

define WSTD_DLAY_CONFIGURE_CMDS
	# install hvcc
	# --break-system-packages
	pip3 install git+https://github.com/Wasted-Audio/hvcc.git \
		--disable-pip-version-check \
		--isolated \
		--no-cache-dir
endef

define WSTD_DLAY_BUILD_CMDS
	# create dpf-based build project
	hvcc $(@D)/wstd_dlay.pd -m $(@D)/wstd_dlay.json -g dpf -p $(@D)/dep $(@D)/dep/heavylib -o $(@D)/build

	# build dpf project
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) NOOPT=true -C $(@D)/build
endef

define WSTD_DLAY_INSTALL_TARGET_CMDS
	cp -r $(@D)/build/bin/*.lv2 $(TARGET_DIR)/usr/lib/lv2/
endef

$(eval $(generic-package))
