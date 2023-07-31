#!/bin/bash

set -e

# rename boot binaries to include board name
[ -f ${BINARIES_DIR}/Image        ] && mv ${BINARIES_DIR}/Image        ${BINARIES_DIR}/Image-ff-px30
[ -f ${BINARIES_DIR}/moddwarf.dtb ] && mv ${BINARIES_DIR}/moddwarf.dtb ${BINARIES_DIR}/moddwarf-ff-px30.dtb

exit 0
