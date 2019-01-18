######################################
#
# camomile-examples
#
######################################

CAMOMILE_EXAMPLES_VERSION = 17d23944bbdfe1eb36e6325cfd9868f52bceef6e
CAMOMILE_EXAMPLES_SITE = $(call github,pierreguillot,Camomile,$(CAMOMILE_EXAMPLES_VERSION))
CAMOMILE_EXAMPLES_DEPENDENCIES = camomile
CAMOMILE_EXAMPLES_BUNDLES = AlmondOrgan.lv2 Bulgroz.lv2 Castafiore.lv2 MiniMock.lv2 PdStalFx.lv2

define CAMOMILE_EXAMPLES_BUILD_CMDS
	# Copy Camomile so file
	install -m 644 $(CAMOMILE_SO_FILE) $(@D)/Plugins/Examples/AlmondOrgan/AlmondOrgan.so
	install -m 644 $(CAMOMILE_SO_FILE) $(@D)/Plugins/Examples/Bulgroz/Bulgroz.so
	install -m 644 $(CAMOMILE_SO_FILE) $(@D)/Plugins/Examples/Castafiore/Castafiore.so
	install -m 644 $(CAMOMILE_SO_FILE) $(@D)/Plugins/Examples/MiniMock/MiniMock.so
	install -m 644 $(CAMOMILE_SO_FILE) $(@D)/Plugins/Examples/PdStalFx/PdStalFx.so

	# Generate TTL
	(cd $(@D)/Plugins/Examples/AlmondOrgan && $(CAMOMILE_SO_GEN) ./AlmondOrgan.so)
	(cd $(@D)/Plugins/Examples/Bulgroz     && $(CAMOMILE_SO_GEN) ./Bulgroz.so)
	(cd $(@D)/Plugins/Examples/Castafiore  && $(CAMOMILE_SO_GEN) ./Castafiore.so)
	(cd $(@D)/Plugins/Examples/MiniMock    && $(CAMOMILE_SO_GEN) ./MiniMock.so)
	(cd $(@D)/Plugins/Examples/PdStalFx    && $(CAMOMILE_SO_GEN) ./PdStalFx.so)
endef

define CAMOMILE_EXAMPLES_INSTALL_TARGET_CMDS
	install -d $(TARGET_DIR)/usr/lib/lv2

	rm -rf $(TARGET_DIR)/usr/lib/lv2/AlmondOrgan.lv2
	cp -r $(@D)/Plugins/Examples/AlmondOrgan $(TARGET_DIR)/usr/lib/lv2/AlmondOrgan.lv2

	rm -rf $(TARGET_DIR)/usr/lib/lv2/Bulgroz.lv2
	cp -r $(@D)/Plugins/Examples/Bulgroz $(TARGET_DIR)/usr/lib/lv2/Bulgroz.lv2

	rm -rf $(TARGET_DIR)/usr/lib/lv2/Castafiore.lv2
	cp -r $(@D)/Plugins/Examples/Castafiore $(TARGET_DIR)/usr/lib/lv2/Castafiore.lv2

	rm -rf $(TARGET_DIR)/usr/lib/lv2/MiniMock.lv2
	cp -r $(@D)/Plugins/Examples/MiniMock $(TARGET_DIR)/usr/lib/lv2/MiniMock.lv2

	rm -rf $(TARGET_DIR)/usr/lib/lv2/PdStalFx.lv2
	cp -r $(@D)/Plugins/Examples/PdStalFx $(TARGET_DIR)/usr/lib/lv2/PdStalFx.lv2
endef

$(eval $(generic-package))
