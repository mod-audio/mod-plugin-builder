mod-plugin-builder
==================

This repository contains the toolchain and libraries used in MOD Devices.

It allows developers to build plugins for MOD Duo and prepare for Cloud builds.

To begin simply run the bootstrap.sh script.
There are several dependencies:
 - git
 - svn
 - hg/mercurial
 - gcc & g++
 - jq
 - wget

The bootstrap.sh script will build the toolchain (ct-ng) and buildroot.
Depending on your machine it can take more than 1 hour.

All files will be installed in ~/mod-workdir.
Set the 'WORKDIR' environment variable if you wish to change that.

After the bootstrap process is complete, you can start building plugins.
See the 'plugins' folder in this repository for some examples.
We categorized them by their respective build system.
Alternately, you can use the toolchain in ~/mod-workdir/toolchain directly.

To build a plugin, run:
```./build <plugin-package>```

If everything goes well, you will have the final plugin bundle in ~/workdir/plugins.
You can use MOD-SDK 'publish' tab to push those into a MOD Duo.
