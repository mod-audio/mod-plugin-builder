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
fi

#######################################################################################################################
# build crosstool-ng

cd ${BUILD_DIR}/${CT_NG_VERSION}

if [ ! -f patches/gcc/4.9.3/132-build_gcc-5_with_gcc-6.patch ]; then
    wget https://raw.githubusercontent.com/crosstool-ng/crosstool-ng/5a5fcbe148acf35372ecac145816c3515e6b8839/patches/gcc/5.3.0/130-build_gcc-5_with_gcc-6.patch
    cp 130-build_gcc-5_with_gcc-6.patch patches/gcc/4.9.3/
    cp 130-build_gcc-5_with_gcc-6.patch patches/gcc/5.2.0/
    rm 130-build_gcc-5_with_gcc-6.patch
fi

if [ ! -f .config ]; then
  cp ${SOURCE_DIR}/toolchain/modduo.config .config
  sed -i "s|CT_LOCAL_TARBALLS_DIR=.*|CT_LOCAL_TARBALLS_DIR=\"${DOWNLOAD_DIR}\"|" .config
  sed -i "s|CT_PREFIX_DIR=.*|CT_PREFIX_DIR=\"${TOOLCHAIN_DIR}\"|" .config
fi

if [ ! -f .stamp_configured ]; then
  ./configure --enable-local
  touch .stamp_configured
fi

if [ ! -f .stamp_built1 ]; then
  make
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

make O=${WORKDIR}/${build} BR2_EXTERNAL=${SOURCE_DIR}/${build} modduo_defconfig

if [[ "${build}" == "plugins-dep" ]]; then
  make O=${WORKDIR}/${build} BR2_EXTERNAL=${SOURCE_DIR}/${build}
fi

#######################################################################################################################
