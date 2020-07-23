######################################
#
# sorcer-labs
#
######################################

SORCER_LABS_VERSION = 0a8cef484174aae5c1b7be6710f31a643e7d7197
SORCER_LABS_SITE = $(call github,harryhaaren,openAV-Sorcer,$(SORCER_LABS_VERSION))
SORCER_LABS_BUNDLES = sorcer.lv2

$(eval $(cmake-package))
