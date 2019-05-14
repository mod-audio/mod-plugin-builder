#!/bin/bash

source .common

#######################################################################################################################
# download and extract crosstool-ng

if [ ! -f ${BUILD_DIR}/${CT_NG_VERSION}/configure ]; then
  if [ ! -f ${DOWNLOAD_DIR}/${CT_NG_FILE} ]; then
    wget ${CT_NG_LINK}/${CT_NG_FILE} -O ${DOWNLOAD_DIR}/${CT_NG_FILE}
  fi

  mkdir -p ${BUILD_DIR}/${CT_NG_VERSION}
  tar xf ${DOWNLOAD_DIR}/${CT_NG_FILE} -C ${BUILD_DIR}/${CT_NG_VERSION} --strip-components=1

  patch -d ${BUILD_DIR}/${CT_NG_VERSION} -p1 -i ${SOURCE_DIR}/patches/crosstool-ng-binutils-2.26.patch
  cp -r ${SOURCE_DIR}/patches/bin-utils-2.26 ${BUILD_DIR}/${CT_NG_VERSION}/patches/binutils/
fi

#######################################################################################################################
# build crosstool-ng

cd ${BUILD_DIR}/${CT_NG_VERSION}

if [ ! -f patches/gcc/4.9.3/0001-fixed-build-with-gcc-6.patch ]; then
    cp ${SOURCE_DIR}/patches/0001-fixed-build-with-gcc-6.patch patches/gcc/4.9.3/0001-fixed-build-with-gcc-6.patch
fi

if [ ! -f .config ]; then
  cp ${SOURCE_DIR}/toolchain/${platform}.config .config
  sed -i "s|CT_LOCAL_TARBALLS_DIR=.*|CT_LOCAL_TARBALLS_DIR=\"${DOWNLOAD_DIR}\"|" .config
  sed -i "s|CT_PREFIX_DIR=.*|CT_PREFIX_DIR=\"${TOOLCHAIN_DIR}\"|" .config
fi

if [ ! -f .stamp_configured ]; then
  ./configure --enable-local
  touch .stamp_configured
fi

if [ ! -f .stamp_built1 ]; then
  sed -i Makefile -e 's/ifneq ($(strip $(CT_MAKEFLAGS)),)/ifneq (,)/'
  make build-bin build-lib
  touch .stamp_built1
fi

if [ ! -f .stamp_built2 ]; then
  ./ct-ng build
  touch .stamp_built2
fi

#######################################################################################################################
# download and extract buildroot

if [ ! -d ${BUILD_DIR}/${BUILDROOT_VERSION} ]; then
  if [ ! -f ${DOWNLOAD_DIR}/${BUILDROOT_FILE} ]; then
    wget ${BUILDROOT_LINK}/${BUILDROOT_FILE} -O ${DOWNLOAD_DIR}/${BUILDROOT_FILE}
  fi

  tar xf ${DOWNLOAD_DIR}/${BUILDROOT_FILE} -C ${BUILD_DIR}

  cd ${BUILD_DIR}/${BUILDROOT_VERSION}
  patch -p1 -i ${SOURCE_DIR}/patches/buildroot-2016.02-a53.patch
  patch -p1 -i ${SOURCE_DIR}/patches/buildroot-automake-fix-unescaped-left-brace-warning-patch
fi

#######################################################################################################################
# buildroot setup

export DOWNLOAD_PATH=${DOWNLOAD_DIR}
export TOOLCHAIN_PATH=${TOOLCHAIN_DIR}

mkdir -p /tmp/skeleton/usr/bin
mkdir -p /tmp/skeleton/usr/lib
mkdir -p /tmp/skeleton/usr/sbin
ln -sf usr/bin  /tmp/skeleton/
ln -sf usr/lib  /tmp/skeleton/
ln -sf usr/sbin /tmp/skeleton/

#######################################################################################################################
# initial first build

cd ${BUILD_DIR}/${BUILDROOT_VERSION}

for dir in `ls ${SOURCE_DIR}/global-packages`; do
    rm -rf package/${dir}
    cp -r ${SOURCE_DIR}/global-packages/${dir} package/${dir}
done

if [ ! -f package/libglib2/001-glib-gdate-suppress-string-format-literal-warning.patch ]; then
    cp ${SOURCE_DIR}/patches/001-glib-gdate-suppress-string-format-literal-warning.patch package/libglib2/
fi

# apply superseded patch from https://patchwork.ozlabs.org/patch/714012/
# fixes python modules build when local ssl is present
cp ${SOURCE_DIR}/patches/111-optional-ssl.patch package/python/

make O=${WORKDIR}/${build} BR2_EXTERNAL=${SOURCE_DIR}/${build} ${platform}_defconfig

if [[ "${build}" == "plugins-dep" ]]; then
  make O=${WORKDIR}/${build} BR2_EXTERNAL=${SOURCE_DIR}/${build}
fi

#######################################################################################################################
