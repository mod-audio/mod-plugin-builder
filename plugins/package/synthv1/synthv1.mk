SYNTHV1_VERSION = 0.7.1
SYNTHV1_SITE = http://download.sourceforge.net/synthv1/
SYNTHV1_SOURCE = synthv1-$(SYNTHV1_VERSION).tar.gz
SYNTHV1_DEPENDENCIES = qt5base host-qt5base
SYNTHV1_BUNDLES = 

$(eval $(autotools-package))
