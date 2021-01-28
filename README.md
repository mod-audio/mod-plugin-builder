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
sudo apt install acl bc curl cvs git mercurial rsync subversion wget \
bison bzip2 flex gawk gperf gzip help2man nano perl patch tar texinfo unzip \
automake binutils build-essential cpio libtool libncurses-dev pkg-config libtool-bin
```

Note that libtool-bin is not available on old distros.<br/>
If that is the case for you, simply skip that package but install everything else.

To begin simply run the bootstrap.sh script with either modduo or modduox as argument.<br/>
The bootstrap.sh script will build the toolchain (ct-ng) and buildroot.<br/>
Depending on your machine it can take more than 1 hour.<br/>

All files will be installed in `~/mod-workdir`.<br/>
Set the 'WORKDIR' environment variable before bootstraping if you wish to change that.

After the bootstrap process is complete, you can start building plugins.<br/>
See the 'plugins/package' folder in this repository for some examples.

### Building plugins

To build a plugin, run:<br/>
```./build <platform> <plugin-package>```

Where `platform` is either modduo, modduox, moddwarf or x86_64 and `plugin-package` is a folder inside the `plugins/package` directory.

If everything goes well, you will have the final plugin bundle in `~/mod-workdir/<platform>/plugins`.<br/>

To push the build plugin onto a MOD Device, run:<br/>
```./publish <platform> <plugin-package>```
Or if you feel like doing it manually, you can run something like:
```
cd /path/to/mod-workdir/plugins # adjust as needed
tar czf bundle1.lv2 bundle2.lv2 | base64 | curl -F 'package=@-' http://192.168.51.1/sdk/install; echo
```

NOTE: If you want to build the provided plugins in this repository you'll need to enable git submodules, like this:
```
git submodule init
git submodule update
```

To cleanup the build of a plugin, run:<br/>
```./build <platform> <plugin-package>-dirclean```


There's a more detailed [HowTo](http://wiki.moddevices.com/wiki/How_To_Build_and_Deploy_LV2_Plugin_to_MOD_Duo) explaining how to compile an LV2 Plugin using mod-plugin-builder.

### Validating plugins (experimental)

It's possible to use the mod-plugin-builder to test a few aspects of a plugin. It's important that the plugin has been built successfully before running this test. 

Firstly, the test can be used for ttl syntax validation. This is done through lv2/sord_validate.
These tools need to be installed on the system. 
On a Debian based system these can be installed by running:<br/>
```
sudo apt install lilv-utils sordi
```
Secondly, this test can also be used for runtime tests for all x86_64 builds.

To do the test, run:<br/>
```
./validate <platform> <plugin-package>
```  

The runtime test (for `x86_64` plugins) can also be combined with valgrind for detecting memory issues.

For running this test do:<br/>
```
VALGRIND=1 ./validate <platform> <plugin-package>
```

### Note about Camomile

The Camomile integration is under testing phase. Check the [PR notes](https://github.com/moddevices/mod-plugin-builder/pull/28) for more details. 

