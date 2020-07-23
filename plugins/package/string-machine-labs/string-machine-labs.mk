######################################
#
# string-machine-labs
#
######################################

STRING_MACHINE_LABS_VERSION = 20cba64cb518bdd4008056f8045e6d9bad4233cb
STRING_MACHINE_LABS_SITE = $(call github,jpcima,string-machine,$(STRING_MACHINE_LABS_VERSION))
STRING_MACHINE_LABS_BUNDLES = string-machine.lv2 string-machine-chorus.lv2 string-machine-chorus-stereo.lv2

STRING_MACHINE_LABS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) HAVE_CAIRO=false HAVE_GL=false NOOPT=true -C $(@D)

# needed for git submodules
define STRING_MACHINE_LABS_EXTRACT_CMDS
	rm -rf $(@D)
	git clone --recursive git://github.com/jpcima/string-machine $(@D)
	(cd $(@D) && \
		git reset --hard $(STRING_MACHINE_LABS_VERSION) && \
		git submodule update)
	touch $(@D)/.stamp_downloaded
endef

define STRING_MACHINE_LABS_BUILD_CMDS
	$(STRING_MACHINE_LABS_TARGET_MAKE)
endef

define STRING_MACHINE_LABS_INSTALL_TARGET_CMDS
	$(STRING_MACHINE_LABS_TARGET_MAKE) install PREFIX=/usr DESTDIR=$(TARGET_DIR)
endef

$(eval $(generic-package))
