SORCER_VERSION = 9da6481cb609cd3aa7a9c988fab2f66571c2b04b
SORCER_SITE = $(call github,harryhaaren,openAV-Sorcer,$(SORCER_VERSION))
SORCER_BUNDLES = 

$(eval $(cmake-package))
