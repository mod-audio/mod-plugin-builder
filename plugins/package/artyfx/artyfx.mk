######################################
#
# artyfx
#
######################################

ARTYFX_VERSION = 9b147f25c5b0e45e52c10d9b148ff04e7cc24951
ARTYFX_SITE = $(call github,harryhaaren,openAV-ArtyFX,$(ARTYFX_VERSION))
ARTYFX_DEPENDENCIES = libsndfile
ARTYFX_CONF_OPTS = -DBUILD_GUI=OFF -DBUILD_SSE=OFF
ARTYFX_BUNDLES = artyfx.lv2 artyfx-bitta.lv2

define ARTYFX_POST_INSTALL_TARGET_TTLFILES
	cp -rL $($(PKG)_PKGDIR)/artyfx.lv2/* $(TARGET_DIR)/usr/lib/lv2/artyfx.lv2/
	# unused plugins
	rm $(TARGET_DIR)/usr/lib/lv2/artyfx.lv2/bitta.ttl
	rm $(TARGET_DIR)/usr/lib/lv2/artyfx.lv2/capta.ttl
	rm $(TARGET_DIR)/usr/lib/lv2/artyfx.lv2/della.ttl
	rm $(TARGET_DIR)/usr/lib/lv2/artyfx.lv2/ducka.ttl
	rm $(TARGET_DIR)/usr/lib/lv2/artyfx.lv2/friza.ttl
	rm $(TARGET_DIR)/usr/lib/lv2/artyfx.lv2/masha.ttl
	rm $(TARGET_DIR)/usr/lib/lv2/artyfx.lv2/panda.ttl
	rm $(TARGET_DIR)/usr/lib/lv2/artyfx.lv2/satma.ttl
	rm $(TARGET_DIR)/usr/lib/lv2/artyfx.lv2/vihda.ttl
	rm $(TARGET_DIR)/usr/lib/lv2/artyfx.lv2/whaaa.ttl

	# bitta split bundle
	install -d $(TARGET_DIR)/usr/lib/lv2/artyfx-bitta.lv2
	cp $(TARGET_DIR)/usr/lib/lv2/artyfx.lv2/*.* $(TARGET_DIR)/usr/lib/lv2/artyfx-bitta.lv2/
	cp -rL $($(PKG)_PKGDIR)/artyfx-bitta.lv2/* $(TARGET_DIR)/usr/lib/lv2/artyfx-bitta.lv2/
endef

ARTYFX_POST_INSTALL_TARGET_HOOKS += ARTYFX_POST_INSTALL_TARGET_TTLFILES

$(eval $(cmake-package))
