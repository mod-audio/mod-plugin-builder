######################################
#
# amsynth
#
######################################

AMSYNTH_VERSION = 1.6.3
AMSYNTH_SITE = https://github.com/amsynth/amsynth/releases/download/release-$(AMSYNTH_VERSION)/
AMSYNTH_SOURCE = amsynth-$(AMSYNTH_VERSION).tar.gz
AMSYNTH_BUNDLES = 

# we modify configure.ac via patch, so we need to regenerate configure
AMSYNTH_AUTORECONF = YES

AMSYNTH_CONF_OPTS += --with-gui=no
AMSYNTH_CONF_OPTS += --with-oss=no
AMSYNTH_CONF_OPTS += --with-alsa=no
AMSYNTH_CONF_OPTS += --with-jack=no
AMSYNTH_CONF_OPTS += --with-lash=no
AMSYNTH_CONF_OPTS += --with-sndfile=no
AMSYNTH_CONF_OPTS += --with-dssi=no
AMSYNTH_CONF_OPTS += --with-vst=no
AMSYNTH_CONF_OPTS += --with-lv2=yes

define AMSYNTH_POST_INSTALL_TARGET_TTLFILES
	cp -rL $($(PKG)_PKGDIR)/amsynth.lv2/* $(TARGET_DIR)/usr/lib/lv2/amsynth.lv2/
endef

AMSYNTH_POST_INSTALL_TARGET_HOOKS += AMSYNTH_POST_INSTALL_TARGET_TTLFILES

$(eval $(autotools-package))
