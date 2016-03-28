mod-plugin-builder
==================

This repository contains the toolchain and libraries used in MOD Devices.

It allows developers to locally build plugins for MOD Duo and also prepare for Cloud builds.

There are several dependencies:
 - gcc & g++
 - git
 - svn
 - hg/mercurial
 - wget
 - bison
 - flex
 - gperf
 - texinfo

To begin simply run the bootstrap.sh script.<br/>
The bootstrap.sh script will build the toolchain (ct-ng) and buildroot.<br/>
Depending on your machine it can take more than 1 hour.<br/>

All files will be installed in ~/mod-workdir.<br/>
Set the 'WORKDIR' environment variable if you wish to change that.

After the bootstrap process is complete, you can start building plugins.<br/>
See the 'plugins' folder in this repository for some examples.

To build a plugin, run:<br/>
```./build <plugin-package>```

If everything goes well, you will have the final plugin bundle in ~/workdir/plugins.<br/>
You can use MOD-SDK's 'publish' tab to push those into a MOD Duo.

To cleanup the build of a plugin, run:<br/>
```./build <plugin-package>-dirclean```
