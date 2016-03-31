######################################
#
# x42-plugins
#
######################################

X42_PLUGINS_VERSION = 20150702
X42_PLUGINS_SITE = http://gareus.org/misc/x42-plugins/
X42_PLUGINS_SOURCE = x42-plugins-$(X42_PLUGINS_VERSION).tar.xz
X42_PLUGINS_DEPENDENCIES = fftwf libglib2 libsamplerate libsndfile zita-convolver
X42_PLUGINS_BUNDLES = balance.lv2 convo.lv2 midifilter.lv2 nodelay.lv2 xfade.lv2

X42_PLUGINS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) OPTIMIZATIONS="" BUILDOPENGL=no BUILDGTK=no HAVE_UI=no LIBZITACONVOLVER="-lzita-convolver" PREFIX=/usr -C $(@D)

define X42_PLUGINS_BUILD_CMDS
	$(X42_PLUGINS_TARGET_MAKE)
endef

define X42_PLUGINS_INSTALL_TARGET_CMDS
	$(X42_PLUGINS_TARGET_MAKE) install DESTDIR=$(TARGET_DIR)
	cp -rL $(BR2_EXTERNAL)/../plugins/package/x42-plugins/balance.lv2/*    $(TARGET_DIR)/usr/lib/lv2/balance.lv2/
	cp -rL $(BR2_EXTERNAL)/../plugins/package/x42-plugins/convo.lv2/*      $(TARGET_DIR)/usr/lib/lv2/convo.lv2/
	cp -rL $(BR2_EXTERNAL)/../plugins/package/x42-plugins/midifilter.lv2/* $(TARGET_DIR)/usr/lib/lv2/midifilter.lv2/
	cp -rL $(BR2_EXTERNAL)/../plugins/package/x42-plugins/nodelay.lv2/*    $(TARGET_DIR)/usr/lib/lv2/nodelay.lv2/
	cp -rL $(BR2_EXTERNAL)/../plugins/package/x42-plugins/xfade.lv2/*      $(TARGET_DIR)/usr/lib/lv2/xfade.lv2/
endef

$(eval $(generic-package))
