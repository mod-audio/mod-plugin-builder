######################################
#
# sorcer
#
######################################

SORCER_VERSION = 0a8cef484174aae5c1b7be6710f31a643e7d7197
SORCER_SITE = $(call github,harryhaaren,openAV-Sorcer,$(SORCER_VERSION))
SORCER_BUNDLES = sorcer.lv2

$(eval $(cmake-package))
