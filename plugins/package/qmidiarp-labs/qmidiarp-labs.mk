######################################
#
# qmidiarp-labs
#
######################################

QMIDIARP_LABS_VERSION = 0.6.3
QMIDIARP_LABS_SITE = http://download.sourceforge.net/qmidiarp/
QMIDIARP_LABS_SOURCE = qmidiarp-$(QMIDIARP_LABS_VERSION).tar.bz2
QMIDIARP_LABS_DEPENDENCIES = qt5base
QMIDIARP_LABS_BUNDLES =

$(eval $(autotools-package))
