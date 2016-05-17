######################################
#
# python-mpmath
#
######################################

HOST_PYTHON_MPMATH_SOURCE = mpmath-0.19.tar.gz
HOST_PYTHON_MPMATH_SITE = https://pypi.python.org/packages/source/m/mpmath
HOST_PYTHON_MPMATH_VERSION = 0.19
HOST_PYTHON_MPMATH_SETUP_TYPE = setuptools

$(eval $(host-python-package))
