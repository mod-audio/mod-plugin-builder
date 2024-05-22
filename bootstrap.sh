#!/bin/bash

cd $(dirname ${0})

#######################################################################################################################
# check arguments

PLATFORM=${1}
BUILDTARGET=${2}

if [ -z "${PLATFORM}" ] || [ ! -e "plugins-dep/configs/${PLATFORM}_defconfig" ]; then
  echo "Usage: $0 <platform> [build-target]"
  echo "  Where platform can be one of: $(echo $(ls plugins-dep/configs | grep _defconfig | sed 's/_defconfig//g' | sort))"
  exit 1
fi

if [ "${BUILDTARGET}" = "kernel" ]; then
  PLATFORM+="-kernel"
fi

#######################################################################################################################
# Import common code and variables

source .common

#######################################################################################################################
# download and extract crosstool-ng

if [ ! -f ${TOOLCHAIN_BUILD_DIR}/${CT_NG_VERSION}/configure ]; then
  if [ ! -f ${DOWNLOAD_DIR}/${CT_NG_FILE} ]; then
    wget ${CT_NG_LINK}/${CT_NG_FILE} -O ${DOWNLOAD_DIR}/${CT_NG_FILE}
  fi

  if [ -n "${CT_NG_KERNEL_FILE}" ] && [ ! -f ${DOWNLOAD_DIR}/${CT_NG_KERNEL_FILE} ]; then
    wget https://cdn.kernel.org/pub/linux/kernel/v6.x/${CT_NG_KERNEL_FILE} -O ${DOWNLOAD_DIR}/${CT_NG_KERNEL_FILE}
  fi

  mkdir -p ${TOOLCHAIN_BUILD_DIR}/${CT_NG_VERSION}
  tar xf ${DOWNLOAD_DIR}/${CT_NG_FILE} -C ${TOOLCHAIN_BUILD_DIR}/${CT_NG_VERSION} --strip-components=1

  case "${CT_NG_VERSION}" in
    "crosstool-ng-1.22.0")
      patch -d ${TOOLCHAIN_BUILD_DIR}/${CT_NG_VERSION} -p1 -i ${SOURCE_DIR}/patches/${CT_NG_VERSION}/001_bash5-compat.patch
      patch -d ${TOOLCHAIN_BUILD_DIR}/${CT_NG_VERSION} -p1 -i ${SOURCE_DIR}/patches/${CT_NG_VERSION}/002_binutils-2.26.patch
      patch -d ${TOOLCHAIN_BUILD_DIR}/${CT_NG_VERSION} -p1 -i ${SOURCE_DIR}/patches/${CT_NG_VERSION}/003_linaro-2017.01.patch

      mkdir -p ${TOOLCHAIN_BUILD_DIR}/${CT_NG_VERSION}/patches/gcc/linaro-4.9-2017.01

      cp -r ${SOURCE_DIR}/patches/${CT_NG_VERSION}/bin-utils-2.26    ${TOOLCHAIN_BUILD_DIR}/${CT_NG_VERSION}/patches/binutils/2.26
      cp    ${SOURCE_DIR}/patches/${CT_NG_VERSION}/gcc-4.9.3/*.patch ${TOOLCHAIN_BUILD_DIR}/${CT_NG_VERSION}/patches/gcc/4.9.3/
      cp    ${SOURCE_DIR}/patches/${CT_NG_VERSION}/gcc-linaro-4.9-2017.01/*.patch ${TOOLCHAIN_BUILD_DIR}/${CT_NG_VERSION}/patches/gcc/linaro-4.9-2017.01/
    ;;

    "crosstool-ng-1.24.0")
      patch -d ${TOOLCHAIN_BUILD_DIR}/${CT_NG_VERSION} -p1 -i ${SOURCE_DIR}/patches/${CT_NG_VERSION}/001_linaro-2019.12.patch
      patch -d ${TOOLCHAIN_BUILD_DIR}/${CT_NG_VERSION} -p1 -i ${SOURCE_DIR}/patches/${CT_NG_VERSION}/002_linaro-gcc7-selects.patch
    ;;

    "crosstool-ng-1.25.0")
      cp ${SOURCE_DIR}/patches/${CT_NG_VERSION}/glibc-2.27/*.patch ${TOOLCHAIN_BUILD_DIR}/${CT_NG_VERSION}/packages/glibc/2.27/
      cp ${SOURCE_DIR}/patches/${CT_NG_VERSION}/glibc-2.34/*.patch ${TOOLCHAIN_BUILD_DIR}/${CT_NG_VERSION}/packages/glibc/2.34/
      cp ${SOURCE_DIR}/patches/${CT_NG_VERSION}/glibc-2.35/*.patch ${TOOLCHAIN_BUILD_DIR}/${CT_NG_VERSION}/packages/glibc/2.35/

      if [ "${TOOLCHAIN_PLATFORM}" == "moddwarf-new" ]; then
        cp ${SOURCE_DIR}/patches/${CT_NG_VERSION}/glibc-2.27-dwarf/*.patch ${TOOLCHAIN_BUILD_DIR}/${CT_NG_VERSION}/packages/glibc/2.27/
      fi
    ;;
  esac
fi

#######################################################################################################################
# build crosstool-ng

cd ${TOOLCHAIN_BUILD_DIR}/${CT_NG_VERSION}

if [ ! -f .config ]; then
  cp ${SOURCE_DIR}/toolchain/${TOOLCHAIN_PLATFORM}.config .config
  sed -i -e "s|CT_LOCAL_TARBALLS_DIR=.*|CT_LOCAL_TARBALLS_DIR=\"${DOWNLOAD_DIR}\"|" .config
  sed -i -e "s|CT_PREFIX_DIR=.*|CT_PREFIX_DIR=\"${TOOLCHAIN_DIR}\"|" .config
  if [ -n "${CT_NG_KERNEL_FILE}" ]; then
    sed -i -e "s|CT_LINUX_CUSTOM_LOCATION=.*|CT_LINUX_CUSTOM_LOCATION=\"${DOWNLOAD_DIR}/${CT_NG_KERNEL_FILE}\"|" .config
  fi
  # static toolchains not supported under macOS, see https://github.com/crosstool-ng/crosstool-ng/issues/396
  if [ -d "/opt/homebrew/opt/binutils/bin" ]; then
    sed -i -e "/CT_WANTS_STATIC_LINK/d" .config
  fi
fi

if [ ! -f .stamp_configured ]; then
  # ./bootstrap
  ./configure --enable-local
  touch .stamp_configured
fi

if [ ! -f .stamp_built1 ]; then
  # ct-ng 1.22 does not build correctly against latest distros
  if [ "${CT_NG_VERSION}" = "crosstool-ng-1.22.0" ]; then
    sed -i -e 's/ifneq ($(strip $(CT_MAKEFLAGS)),)/ifneq (,)/' Makefile
    make build-bin build-lib
  else
    make
  fi
  touch .stamp_built1
fi

# for static targets: keep old name for backwards compatibility, plus add static suffix
if [ ! -f .stamp_patched ]; then
  if [ "${TOOLCHAIN_PLATFORM}" == "modduo-static" ]; then
    sed -i -e 's/CT_TARGET_SYS="${CT_TARGET_SYS}hf"/CT_TARGET_SYS="${CT_TARGET_SYS}hf.static"/' scripts/build/arch/arm.sh
  elif [ "${TOOLCHAIN_PLATFORM}" == "modduox-new" ]; then
    sed -i -e 's/CT_TARGET_SYS=gnu;/CT_TARGET_SYS=gnueabi;/' scripts/functions
  elif [ "${TOOLCHAIN_PLATFORM}" == "modduox-static" ]; then
    sed -i -e 's/CT_TARGET_SYS=gnu;/CT_TARGET_SYS=gnueabi.static;/' scripts/functions
  fi
  touch .stamp_patched
fi

# workaround for isl download
if [ "${CT_NG_VERSION}" = "crosstool-ng-1.22.0" ] && [ ! -f build/tarballs/isl-0.12.2.tar.bz2 ]; then
  mkdir -p build/tarballs
  cd build/tarballs
  wget -c https://launchpad.net/ubuntu/+archive/primary/+sourcefiles/isl/0.12.2-1/isl_0.12.2.orig.tar.bz2
  mv isl_0.12.2.orig.tar.bz2 isl-0.12.2.tar.bz2
  cd ../..
elif [ "${CT_NG_VERSION}" = "crosstool-ng-1.24.0" ] && [ ! -f build/tarballs/isl-0.20.tar.xz ]; then
  mkdir -p build/tarballs
  cd build/tarballs
  wget -c https://launchpad.net/ubuntu/+archive/primary/+sourcefiles/isl/0.20-1/isl_0.20.orig.tar.xz
  mv isl_0.20.orig.tar.xz isl-0.20.tar.xz
  cd ../..
fi

if [ ! -f .stamp_built2 ]; then
  sed -i -e 's/.PHONY: $(PHONY)/.PHONY: build $(PHONY)/' ct-ng
  ./ct-ng build
  touch .stamp_built2
fi

#######################################################################################################################
# download, extract and patch buildroot

if [ ! -d ${BUILD_DIR}/${BUILDROOT_VERSION} ]; then
  if [ ! -f ${DOWNLOAD_DIR}/${BUILDROOT_FILE} ]; then
    wget ${BUILDROOT_LINK}/${BUILDROOT_FILE} -O ${DOWNLOAD_DIR}/${BUILDROOT_FILE}
  fi

  tar xf ${DOWNLOAD_DIR}/${BUILDROOT_FILE} -C ${BUILD_DIR}

  case "${BUILDROOT_VERSION}" in
    "buildroot-2016.02")
      patch -d ${BUILD_DIR}/${BUILDROOT_VERSION} -p1 -i ${SOURCE_DIR}/patches/${BUILDROOT_VERSION}/001_aarch64-and-cortex-a53.patch
      patch -d ${BUILD_DIR}/${BUILDROOT_VERSION} -p1 -i ${SOURCE_DIR}/patches/${BUILDROOT_VERSION}/002_cortex-a35.patch
      patch -d ${BUILD_DIR}/${BUILDROOT_VERSION} -p1 -i ${SOURCE_DIR}/patches/${BUILDROOT_VERSION}/003_gcc-7.patch
      patch -d ${BUILD_DIR}/${BUILDROOT_VERSION} -p1 -i ${SOURCE_DIR}/patches/${BUILDROOT_VERSION}/004_fix-linux-host-flags.patch
      patch -d ${BUILD_DIR}/${BUILDROOT_VERSION} -p1 -i ${SOURCE_DIR}/patches/${BUILDROOT_VERSION}/005_linux-needs-host-openssl.patch
      patch -d ${BUILD_DIR}/${BUILDROOT_VERSION} -p1 -i ${SOURCE_DIR}/patches/${BUILDROOT_VERSION}/006_linux-fix-hostcc.patch
      patch -d ${BUILD_DIR}/${BUILDROOT_VERSION} -p1 -i ${SOURCE_DIR}/patches/${BUILDROOT_VERSION}/007_static-toolchain.patch
      patch -d ${BUILD_DIR}/${BUILDROOT_VERSION} -p1 -i ${SOURCE_DIR}/patches/${BUILDROOT_VERSION}/008_cortex-a72.patch
      patch -d ${BUILD_DIR}/${BUILDROOT_VERSION} -p1 -i ${SOURCE_DIR}/patches/${BUILDROOT_VERSION}/009_updated-toolchain-2022.patch
      patch -d ${BUILD_DIR}/${BUILDROOT_VERSION} -p1 -i ${SOURCE_DIR}/patches/${BUILDROOT_VERSION}/010_fixpkgconfdownload.patch
      patch -d ${BUILD_DIR}/${BUILDROOT_VERSION} -p1 -i ${SOURCE_DIR}/patches/${BUILDROOT_VERSION}/011_fix-qt5-build.patch
      patch -d ${BUILD_DIR}/${BUILDROOT_VERSION} -p1 -i ${SOURCE_DIR}/patches/${BUILDROOT_VERSION}/012_linux-kernel-6.1.patch
    ;;

    "buildroot-2023.11.3")
    ;;
  esac
fi

for dir in `ls ${SOURCE_DIR}/global-packages/${BUILDROOT_VERSION}`; do
  rm -rf ${BUILD_DIR}/${BUILDROOT_VERSION}/package/${dir}
  cp -r ${SOURCE_DIR}/global-packages/${BUILDROOT_VERSION}/${dir} ${BUILD_DIR}/${BUILDROOT_VERSION}/package/${dir}/
done

for dir in `ls ${SOURCE_DIR}/patches/${BUILDROOT_VERSION}/packages`; do
  cp ${SOURCE_DIR}/patches/${BUILDROOT_VERSION}/packages/${dir}/*.patch ${BUILD_DIR}/${BUILDROOT_VERSION}/package/${dir}/
  for subdir in `ls ${SOURCE_DIR}/patches/${BUILDROOT_VERSION}/packages/${dir} | grep -v '.patch'`; do
    cp ${SOURCE_DIR}/patches/${BUILDROOT_VERSION}/packages/${dir}/${subdir}/*.patch ${BUILD_DIR}/${BUILDROOT_VERSION}/package/${dir}/${subdir}/
  done
done

#######################################################################################################################
# custom skeleton with merged /usr mode

if [ "${BUILDROOT_VERSION}" = "buildroot-2016.02" ]; then
  mkdir -p /tmp/skeleton/usr/bin
  mkdir -p /tmp/skeleton/usr/lib
  mkdir -p /tmp/skeleton/usr/sbin
  ln -sf usr/bin /tmp/skeleton/
  ln -sf usr/lib /tmp/skeleton/
  ln -sf usr/sbin /tmp/skeleton/
fi

#######################################################################################################################
# buildroot setup

export DOWNLOAD_PATH=${DOWNLOAD_DIR}
export TOOLCHAIN_PATH=${TOOLCHAIN_DIR}

cd ${BUILD_DIR}/${BUILDROOT_VERSION}

#######################################################################################################################
# fix missing shared libs

if [ "${TOOLCHAIN_PLATFORM}" = "generic-x86_64" ] && [ ! -e "${BR2_TARGET}/usr/lib/libmvec.so.1" ]; then
  mkdir -p "${BR2_TARGET}/usr/lib"
  cp "${TOOLCHAIN_DIR}/x86_64-modaudio.generic-linux-gnu/sysroot/lib/libmvec.so.1" "${BR2_TARGET}/usr/lib/libmvec.so.1"
fi

#######################################################################################################################
# initial first build

${BR2_MAKE} ${BR2_PLATFORM}_defconfig

if [ "${BUILDTARGET}" = "blackmirror" ]; then
  ${BR2_MAKE} host-cmake
  ${BR2_MAKE} lv2
  ${BR2_MAKE} kxstudio-lv2-extensions
  ${BR2_MAKE} mod-lv2-extensions
  ${BR2_MAKE} qt6httpserver
  ${BR2_MAKE} qt6svg
  ${BR2_MAKE} qt6tools
elif [ "${BUILDTARGET}" = "kernel" ]; then
  ${BR2_MAKE} host-kmod
  ${BR2_MAKE} host-pkgconf
  ${BR2_MAKE} host-openssl
elif [ "${BUILDTARGET}" = "minimal" ]; then
  ${BR2_MAKE} fftw-double
  ${BR2_MAKE} fftw-single
  ${BR2_MAKE} liblo
  ${BR2_MAKE} lv2
  ${BR2_MAKE} kxstudio-lv2-extensions
  ${BR2_MAKE} mod-lv2-extensions
  ${BR2_MAKE} alsa-utils
  if [ "${TOOLCHAIN_PLATFORM}" = "generic-x86_64" ]; then
    ${BR2_MAKE} carla-backend
    ${BR2_MAKE} valgrind
  elif [ "${TOOLCHAIN_PLATFORM}" != "generic-aarch64" ]; then
    ${BR2_MAKE} libmodla
  fi
elif [ "${BUILDTARGET}" = "juce" ]; then
  ${BR2_MAKE} fftw-double
  ${BR2_MAKE} fftw-single
  ${BR2_MAKE} juce-6.0
  ${BR2_MAKE} juce-6.1
  ${BR2_MAKE} juce-7.0
  ${BR2_MAKE} mod-plugin-builder
elif [ "${BUILDTARGET}" = "dev" ]; then
  ${BR2_MAKE} host-python
  # for cc-master
  ${BR2_MAKE} jansson
  ${BR2_MAKE} libserialport
  # for mod-host
  ${BR2_MAKE} jack2mod
  ${BR2_MAKE} hylia
  ${BR2_MAKE} lilv
  ${BR2_MAKE} readline
elif [ "${BUILDTARGET}" != "toolchain" ]; then
  ${BR2_MAKE}
fi

#######################################################################################################################
