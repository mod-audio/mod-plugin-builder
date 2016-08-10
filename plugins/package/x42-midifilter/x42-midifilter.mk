######################################
#
# x42-midifilter
#
######################################

X42_MIDIFILTER_VERSION = 066267565ace93817ff5c2f7187575710ae35edb
X42_MIDIFILTER_SITE = $(call github,x42,midifilter.lv2,$(X42_MIDIFILTER_VERSION))
X42_MIDIFILTER_BUNDLES = midifilter.lv2

X42_MIDIFILTER_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) MOD=1 OPTIMIZATIONS="-fno-finite-math-only" BUILDOPENGL=no BUILDGTK=no HAVE_UI=no PREFIX=/usr -C $(@D)

define X42_MIDIFILTER_BUILD_CMDS
	$(X42_MIDIFILTER_TARGET_MAKE)
endef

define X42_MIDIFILTER_INSTALL_TARGET_CMDS
	$(X42_MIDIFILTER_TARGET_MAKE) install DESTDIR=$(TARGET_DIR)
# 	cp -rL $($(PKG)_PKGDIR)/midifilter.lv2/* $(TARGET_DIR)/usr/lib/lv2/midifilter.lv2/
endef

$(eval $(generic-package))
