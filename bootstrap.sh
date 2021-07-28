#!/bin/bash

#######################################################################################################################
# check arguments

PLATFORM=$1

if [ "${PLATFORM}" == "" ]; then
  echo "Usage: $0 <platform>"
  echo "  Where platform can be modduo, modduox, moddwarf or x86_64"
  exit 1
fi

#######################################################################################################################
# Import common code and variables

source .common

#######################################################################################################################
# download and extract crosstool-ng

if [ ! -f ${BUILD_DIR}/${CT_NG_VERSION}/configure ]; then
  if [ ! -f ${DOWNLOAD_DIR}/${CT_NG_FILE} ]; then
    wget ${CT_NG_LINK}/${CT_NG_FILE} -O ${DOWNLOAD_DIR}/${CT_NG_FILE}
  fi

  mkdir -p ${BUILD_DIR}/${CT_NG_VERSION}
  tar xf ${DOWNLOAD_DIR}/${CT_NG_FILE} -C ${BUILD_DIR}/${CT_NG_VERSION} --strip-components=1

  if [ "${CT_NG_VERSION}" = "crosstool-ng-1.22.0" ]; then
    patch -d ${BUILD_DIR}/${CT_NG_VERSION} -p1 -i ${SOURCE_DIR}/patches/${CT_NG_VERSION}/001_bash5-compat.patch
    patch -d ${BUILD_DIR}/${CT_NG_VERSION} -p1 -i ${SOURCE_DIR}/patches/${CT_NG_VERSION}/002_binutils-2.26.patch
    patch -d ${BUILD_DIR}/${CT_NG_VERSION} -p1 -i ${SOURCE_DIR}/patches/${CT_NG_VERSION}/003_linaro-2017.01.patch

    cp -r ${SOURCE_DIR}/patches/${CT_NG_VERSION}/bin-utils-2.26    ${BUILD_DIR}/${CT_NG_VERSION}/patches/binutils/2.26
    cp    ${SOURCE_DIR}/patches/${CT_NG_VERSION}/gcc-4.9.3/*.patch ${BUILD_DIR}/${CT_NG_VERSION}/patches/gcc/4.9.3/

  elif [ "${CT_NG_VERSION}" = "crosstool-ng-1.24.0" ]; then
    patch -d ${BUILD_DIR}/${CT_NG_VERSION} -p1 -i ${SOURCE_DIR}/patches/${CT_NG_VERSION}/001_linaro-2019.12.patch
    patch -d ${BUILD_DIR}/${CT_NG_VERSION} -p1 -i ${SOURCE_DIR}/patches/${CT_NG_VERSION}/002_linaro-gcc7-selects.patch
  fi
fi

#######################################################################################################################
# build crosstool-ng

cd ${BUILD_DIR}/${CT_NG_VERSION}

if [ ! -f .config ]; then
  cp ${SOURCE_DIR}/toolchain/${PLATFORM}.config .config
  sed -i "s|CT_LOCAL_TARBALLS_DIR=.*|CT_LOCAL_TARBALLS_DIR=\"${DOWNLOAD_DIR}\"|" .config
  sed -i "s|CT_PREFIX_DIR=.*|CT_PREFIX_DIR=\"${TOOLCHAIN_DIR}\"|" .config
fi

if [ ! -f .stamp_configured ]; then
  ./configure --enable-local
  touch .stamp_configured
fi

if [ ! -f .stamp_built1 ]; then
  # ct-ng 1.22 does not build correctly against latest distros
  if [ "${CT_NG_VERSION}" = "crosstool-ng-1.22.0" ]; then
    sed -i Makefile -e 's/ifneq ($(strip $(CT_MAKEFLAGS)),)/ifneq (,)/'
    make build-bin build-lib
  else
    make
  fi
  touch .stamp_built1
fi

if [ "${PLATFORM}" == "modduox-static" ]; then
  # keep old name for backwards compatibility, plus add static suffix
  sed -i "s/CT_TARGET_SYS=gnu;/CT_TARGET_SYS=gnueabi.static;/" scripts/functions
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

  patch -d ${BUILD_DIR}/${BUILDROOT_VERSION} -p1 -i ${SOURCE_DIR}/patches/buildroot-2016.02/001_aarch64-and-cortex-a53.patch
  patch -d ${BUILD_DIR}/${BUILDROOT_VERSION} -p1 -i ${SOURCE_DIR}/patches/buildroot-2016.02/002_cortex-a35.patch
  patch -d ${BUILD_DIR}/${BUILDROOT_VERSION} -p1 -i ${SOURCE_DIR}/patches/buildroot-2016.02/003_gcc-7.patch
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

cd ${BUILD_DIR}/${BUILDROOT_VERSION}

#######################################################################################################################
# patching buildroot packages

for dir in `ls ${SOURCE_DIR}/global-packages`; do
    rm -rf package/${dir}
    cp -r ${SOURCE_DIR}/global-packages/${dir} package/${dir}
done

for dir in `ls ${SOURCE_DIR}/patches/packages`; do
    cp ${SOURCE_DIR}/patches/packages/${dir}/*.patch package/${dir}/
done

#######################################################################################################################
# initial first build

${BR2_MAKE} ${PLATFORM}_defconfig
${BR2_MAKE}

#######################################################################################################################
