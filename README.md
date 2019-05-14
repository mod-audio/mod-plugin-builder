mod-plugin-builder
==================

This repository contains the toolchain and libraries used in MOD Devices.

It allows developers to locally build plugins for MOD Duo and also prepare for Cloud builds.<br/>
Currently this builder only supports Linux hosts.<br/>
If you're not running Linux see this [HowTo](http://wiki.moddevices.com/wiki/How_To_Use_Docker_Toolbox_With_MPB).

There are several dependencies:
 - gcc & g++
 - git
 - subversion
 - hg/mercurial
 - autoconf
 - automake
 - bzip2
 - lzma
 - binutils
 - libtool
 - ncurses
 - rsync
 - wget
 - bc
 - bison
 - flex
 - help2man
 - gawk
 - gperf
 - texinfo

If you're running a debian based system you can install all dependencies by running:
```
sudo apt-get install acl bc curl cvs git mercurial rsync subversion wget \
bison bzip2 flex gawk gperf gzip help2man nano perl patch tar texinfo unzip \
automake binutils build-essential cpio libtool libncurses-dev pkg-config libtool-bin
```

Note that libtool-bin is not available on old distros.<br/>
If that is the case for you, simply skip that package but install everything else.

To begin simply run the bootstrap.sh script.<br/>
The bootstrap.sh script will build the toolchain (ct-ng) and buildroot.<br/>
Depending on your machine it can take more than 1 hour.<br/>

All files will be installed in `~/mod-workdir`.<br/>
Set the 'WORKDIR' environment variable if you wish to change that.

After the bootstrap process is complete, you can start building plugins.<br/>
See the 'plugins' folder in this repository for some examples.

To build a plugin, run:<br/>
```./build <plugin-package>```

If everything goes well, you will have the final plugin bundle in `~/workdir/plugins`.<br/>
You can use [MOD-SDK](https://github.com/moddevices/mod-sdk)'s 'publish' tab to push those into a MOD Duo.

NOTE: If you want to build the provided plugins in this repository you'll need to enable git submodules, like this:
```
git submodule init
git submodule update
```

To cleanup the build of a plugin, run:<br/>
```./build <plugin-package>-dirclean```


There's a more detailed [HowTo](http://wiki.moddevices.com/wiki/How_To_Build_and_Deploy_LV2_Plugin_to_MOD_Duo) explaining how to compile an LV2 Plugin using mod-plugin-builder.


### Note about Camomile

The Camomile integration is under testing phase. Check the [PR notes](https://github.com/moddevices/mod-plugin-builder/pull/28) for more details. 

