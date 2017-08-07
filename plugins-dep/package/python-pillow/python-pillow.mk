################################################################################
#
# python-pillow
#
################################################################################

PYTHON_PILLOW_VERSION = 2.8.1
PYTHON_PILLOW_SOURCE = Pillow-$(PYTHON_PILLOW_VERSION).tar.gz
PYTHON_PILLOW_SITE = https://pypi.python.org/packages/source/P/Pillow
PYTHON_PILLOW_DEPENDENCIES = python3 zlib jpeg host-python-setuptools 
PYTHON_PILLOW_SETUP_TYPE = setuptools
PYTHON_PILLOW_ENV = CC=$(TARGET_CC)

$(eval $(python-package))
