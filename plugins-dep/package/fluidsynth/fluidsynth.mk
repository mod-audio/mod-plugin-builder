################################################################################
#
# fluidsynth
#
################################################################################

FLUIDSYNTH_VERSION = 1.1.6
FLUIDSYNTH_SITE = http://download.sourceforge.net/fluidsynth
FLUIDSYNTH_SOURCE = fluidsynth-$(FLUIDSYNTH_VERSION).tar.bz2
FLUIDSYNTH_DEPENDENCIES = libglib2 libsndfile
FLUIDSYNTH_INSTALL_STAGING = YES
FLUIDSYNTH_AUTORECONF = YES

$(eval $(autotools-package))
