QMIDIARP_VERSION = 0.6.3
QMIDIARP_SITE = http://download.sourceforge.net/qmidiarp/
QMIDIARP_SOURCE = qmidiarp-$(QMIDIARP_VERSION).tar.bz2
QMIDIARP_DEPENDENCIES = qt5base
QMIDIARP_BUNDLES = 

$(eval $(autotools-package))
