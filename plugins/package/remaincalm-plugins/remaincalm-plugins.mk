######################################
#
# remaincalm-plugins
#
######################################

REMAINCALM_PLUGINS_VERSION = 19fc07771baff665559ee626c7bfb2ee36311ab1
REMAINCALM_PLUGINS_SITE = $(call github,remaincalm,dpfports,$(REMAINCALM_PLUGINS_VERSION))
REMAINCALM_PLUGINS_BUNDLES = avocado.lv2 floaty.lv2 mud.lv2 paranoia.lv2

REMAINCALM_PLUGINS_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) NOOPT=true

define REMAINCALM_PLUGINS_BUILD_CMDS
	(cd $(@D) && \
		[ ! -d dpf ] && \
		git clone https://github.com/DISTRHO/DPF.git dpf --depth=1 && \
		ln -sf ../dpf avocado/dpf && \
		ln -sf ../dpf floaty/dpf && \
		ln -sf ../dpf mud/dpf && \
		ln -sf ../dpf paranoia/dpf || true)

	$(REMAINCALM_PLUGINS_TARGET_MAKE) -C $(@D)/avocado/source
	$(REMAINCALM_PLUGINS_TARGET_MAKE) -C $(@D)/floaty/source
	$(REMAINCALM_PLUGINS_TARGET_MAKE) -C $(@D)/mud/source
	$(REMAINCALM_PLUGINS_TARGET_MAKE) -C $(@D)/paranoia/source
endef

define REMAINCALM_PLUGINS_INSTALL_TARGET_CMDS
	install -d $(TARGET_DIR)/usr/lib/lv2
	cp -rL $(@D)/avocado/source/build/avocado.lv2   $(TARGET_DIR)/usr/lib/lv2/
	cp -rL $(@D)/floaty/source/build/floaty.lv2     $(TARGET_DIR)/usr/lib/lv2/
	cp -rL $(@D)/mud/source/build/mud.lv2           $(TARGET_DIR)/usr/lib/lv2/
	cp -rL $(@D)/paranoia/source/build/paranoia.lv2 $(TARGET_DIR)/usr/lib/lv2/
	cp -rL $($(PKG)_PKGDIR)/avocado.lv2/*           $(TARGET_DIR)/usr/lib/lv2/avocado.lv2/
	cp -rL $($(PKG)_PKGDIR)/floaty.lv2/*            $(TARGET_DIR)/usr/lib/lv2/floaty.lv2/
	cp -rL $($(PKG)_PKGDIR)/mud.lv2/*               $(TARGET_DIR)/usr/lib/lv2/mud.lv2/
	cp -rL $($(PKG)_PKGDIR)/paranoia.lv2/*          $(TARGET_DIR)/usr/lib/lv2/paranoia.lv2/
endef

$(eval $(generic-package))
