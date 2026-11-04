######################################
#
# jtbasssynth
#
# JTBassSynth by Jonas Temple (jtemple0967 on the forum), monophonic pitch-tracking bass synth
# https://github.com/jtemple967/JTBassSynth
#
######################################

JTBASSSYNTH_VERSION = 268f847fadc0975d02e37e69586c2614e973bc10
JTBASSSYNTH_SITE = https://github.com/jtemple967/JTBassSynth.git
JTBASSSYNTH_SITE_METHOD = git
JTBASSSYNTH_DEPENDENCIES = lv2
JTBASSSYNTH_BUNDLES = JTBassSynth.lv2

JTBASSSYNTH_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)

define JTBASSSYNTH_BUILD_CMDS
	$(JTBASSSYNTH_TARGET_MAKE)
endef

define JTBASSSYNTH_INSTALL_TARGET_CMDS
	$(JTBASSSYNTH_TARGET_MAKE) install INSTALL_DIR=$(TARGET_DIR)/usr/lib/lv2
endef

$(eval $(generic-package))
