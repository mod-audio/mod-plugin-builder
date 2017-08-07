######################################
#
# python-pystache
#
######################################
PYTHON_PYSTACHE_SOURCE = pystache-0.5.4.tar.gz
PYTHON_PYSTACHE_SITE = https://pypi.python.org/packages/source/p/pystache
PYTHON_PYSTACHE_VERSION = 0.5.4
PYTHON_PYSTACHE_SETUP_TYPE = setuptools
PYTHON_PYSTACHE_DEPENDENCIES = host-python-setuptools

$(eval $(python-package))
