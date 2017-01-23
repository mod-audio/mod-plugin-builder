######################################
#
# infamous-plugins
#
######################################

#INFAMOUS_PLUGINS_VERSION = 0.1.3
#release
#INFAMOUS_PLUGINS_SITE = https://github.com/ssj71/infamousPlugins/archive/
#INFAMOUS_PLUGINS_SOURCE = v$(INFAMOUS_PLUGINS_VERSION).tar.gz
#local source
#INFAMOUS_PLUGINS_SITE_METHOD = local
#INFAMOUS_PLUGINS_SITE = /home/spencer/other_programs/infamousplugins-code
#git
INFAMOUS_PLUGINS_VERSION = 1303b0d9b294be9088a4239ec7166151f8906f4c
INFAMOUS_PLUGINS_SITE = $(call github,ssj71,infamousPlugins,$(INFAMOUS_PLUGINS_VERSION))
#envfollower.lv2 ewham.lv2 casynth.lv2 cheapdist.lv2 hip2b.lv2 lushlife.lv2 powercut.lv2 powerup.lv2 stuck.lv2 bentdelay.lv2
INFAMOUS_PLUGINS_BUNDLES = ewham.lv2 stuck.lv2

$(eval $(cmake-package))
