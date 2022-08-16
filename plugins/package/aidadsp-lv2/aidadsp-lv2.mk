######################################
#
# aida dsp lv2 bundle
#
######################################

AIDADSPLV2_VERSION = 2963a6d4996ab291e270c312c8e1ef4380aa6c9a
AIDADSPLV2_SITE = $(call github,aidadsp,aidadsp-lv2,$(AIDADSPLV2_VERSION))
AIDADSPLV2_CONF_OPTS = -DRTNEURAL_ENABLE_AARCH64=ON -DRTNEURAL_XSIMD=ON
AIDADSPLV2_BUNDLES = rt-neural-generic.lv2

$(eval $(cmake-package))
