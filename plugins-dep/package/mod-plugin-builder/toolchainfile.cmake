# CMake toolchain file for Darkglass and MOD builds

set(HOST_DIR "$ENV{HOST_DIR}")
get_filename_component(TARGET_DIR "${HOST_DIR}/../target" REALPATH)

include("${HOST_DIR}/usr/share/buildroot/toolchainfile.cmake")

if(CMAKE_SYSTEM_PROCESSOR STREQUAL "aarch64")
  set(CMAKE_CROSSCOMPILING_EMULATOR qemu-aarch64-static -E LD_LIBRARY_PATH="${TARGET_DIR}/usr/lib" -L "${TARGET_DIR}")
elseif(CMAKE_SYSTEM_PROCESSOR STREQUAL "armv7l")
  set(CMAKE_CROSSCOMPILING_EMULATOR qemu-arm-static -E LD_LIBRARY_PATH="${TARGET_DIR}/usr/lib" -L "${TARGET_DIR}")
elseif(CMAKE_SYSTEM_PROCESSOR STREQUAL "x86_64")
  set(CMAKE_CROSSCOMPILING_EMULATOR qemu-x86_64-static -E LD_LIBRARY_PATH="${TARGET_DIR}/usr/lib" -L "${TARGET_DIR}")
endif()

set(CMAKE_CROSSCOMPILING TRUE)
separate_arguments(CMAKE_CROSSCOMPILING_EMULATOR)
