######################################
#
# airwindows
#
######################################

AIRWINDOWS_VERSION = 9b48123f778e0ed623b0e432695d6b5d32f70638
AIRWINDOWS_SITE = https://github.com/hannesbraun/airwindows-lv2.git
AIRWINDOWS_SITE_METHOD = git
AIRWINDOWS_CONF_OPTS = -DCMAKE_INSTALL_PREFIX=/usr/lib/lv2
AIRWINDOWS_BUNDLES = Airwindows-Dyno.lv2 Airwindows-Mojo.lv2 Airwindows-Spiral.lv2 Airwindows-Galactic.lv2 Airwindows-PocketVerbs.lv2 Airwindows-StarChild.lv2 Airwindows-DeBess.lv2 Airwindows-Baxandall.lv2 Airwindows-Channel8.lv2 Airwindows-EveryTrim.lv2 Airwindows-Mackity.lv2 Airwindows-Acceleration2.lv2 Airwindows-ADClip7.lv2 Airwindows-Capacitor.lv2 Airwindows-Capacitor2.lv2 Airwindows-ClipOnly.lv2 Airwindows-ClipOnly2.lv2 Airwindows-Console7Buss.lv2 Airwindows-Console7Cascade.lv2 Airwindows-Console7Channel.lv2 Airwindows-Console7Crunch.lv2 Airwindows-EdIsDim.lv2 Airwindows-MidSide.lv2 Airwindows-MV.lv2 Airwindows-Nikola.lv2 Airwindows-Pressure5.lv2 Airwindows-Sidepass.lv2 Airwindows-Vibrato.lv2

define AIRWINDOWS_INSTALL_TARGET_CMDS
	rm -rf $(@D)/bundles
	mkdir $(@D)/bundles
	(for p in `ls $(@D)/Airwindows.lv2 | sort | grep -- '\.so'`; do \
		pl=`echo $$p | sed 's/\.so//'`; \
		pll=`echo $$pl | tr '[:upper:]' '[:lower:]'`; \
		mkdir $(@D)/bundles/Airwindows-$$pl.lv2/; \
		cp $(@D)/Airwindows.lv2/$$pl.* $(@D)/bundles/Airwindows-$$pl.lv2/; \
		echo "@prefix lv2:  <http://lv2plug.in/ns/lv2core#> ." > $(@D)/bundles/Airwindows-$$pl.lv2/manifest.ttl; \
		echo "@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> ." >> $(@D)/bundles/Airwindows-$$pl.lv2/manifest.ttl; \
		echo -n "<https://hannesbraun.net/ns/lv2/airwindows/" >> $(@D)/bundles/Airwindows-$$pl.lv2/manifest.ttl; \
		echo -n $$pll >> $(@D)/bundles/Airwindows-$$pl.lv2/manifest.ttl; \
		echo ">" >> $(@D)/bundles/Airwindows-$$pl.lv2/manifest.ttl; \
		echo "a lv2:Plugin ; lv2:binary <$$pl.so> ; rdfs:seeAlso <$$pl.ttl> ." >> $(@D)/bundles/Airwindows-$$pl.lv2/manifest.ttl; \
	done)
	cp -rL $(@D)/bundles/*.lv2 $(TARGET_DIR)/usr/lib/lv2/
	cp -rL $($(PKG)_PKGDIR)/Airwindows-StarChild.lv2/* $(TARGET_DIR)/usr/lib/lv2/Airwindows-StarChild.lv2/
endef

$(eval $(cmake-package))
