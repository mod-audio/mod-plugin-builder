######################################
#
# x42-midifilter
#
######################################

X42_MIDIFILTER_VERSION = 57e937f3132742d96a9654a8424e07c7390923dd
X42_MIDIFILTER_SITE = $(call github,x42,midifilter.lv2,$(X42_MIDIFILTER_VERSION))
X42_MIDIFILTER_BUNDLES = midifilter.lv2

X42_MIDIFILTER_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) midifilter_VERSION=0.4.4-15 $(MAKE) MOD=1 OPTIMIZATIONS="-fno-finite-math-only" BUILDOPENGL=no BUILDGTK=no HAVE_UI=no PREFIX=/usr -C $(@D)

define X42_MIDIFILTER_BUILD_CMDS
	$(X42_MIDIFILTER_TARGET_MAKE)
endef

define X42_MIDIFILTER_INSTALL_TARGET_CMDS
	$(X42_MIDIFILTER_TARGET_MAKE) install DESTDIR=$(TARGET_DIR)
	cp -rL $($(PKG)_PKGDIR)/midifilter.lv2/* $(TARGET_DIR)/usr/lib/lv2/midifilter.lv2/
endef

$(eval $(generic-package))
