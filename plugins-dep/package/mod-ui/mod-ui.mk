######################################
#
# mod-ui
#
######################################

MOD_UI_VERSION = 1356b2351bd2fedbb5bab96a7979e866bd7b8083
MOD_UI_SITE = $(call github,moddevices,mod-ui,$(MOD_UI_VERSION))
MOD_UI_DEPENDENCIES = python3 python-pillow python-pycrypto python-pystache python-setuptools python-serial python-tornado host-python jack2mod lilv
MOD_UI_SETUP_TYPE = distutils
MOD_UI_ENV = CXX=$(TARGET_CXX)

$(eval $(python-package))
