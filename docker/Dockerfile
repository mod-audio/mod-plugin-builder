FROM ubuntu:18.04
LABEL maintainer="Alexandre Cunha <ale@moddevices.com>"
ENV DEBIAN_FRONTEND noninteractive

# platform argument must be provided, e.g. --build-arg platform=modduo
ARG platform=modduo

# enable i386, armhf and arm64
RUN dpkg --add-architecture i386
RUN dpkg --add-architecture armhf
RUN dpkg --add-architecture arm64

RUN echo "deb [arch=amd64,i386] http://archive.ubuntu.com/ubuntu/ bionic main restricted universe multiverse"                > /etc/apt/sources.list && \
    echo "deb [arch=amd64,i386] http://archive.ubuntu.com/ubuntu/ bionic-updates main restricted universe multiverse"       >> /etc/apt/sources.list && \
    echo "deb [arch=amd64,i386] http://archive.ubuntu.com/ubuntu/ bionic-backports main restricted universe multiverse"     >> /etc/apt/sources.list && \
    echo "deb [arch=amd64,i386] http://security.ubuntu.com/ubuntu bionic-security main restricted universe multiverse"      >> /etc/apt/sources.list && \
    echo "deb [arch=armhf,arm64] http://ports.ubuntu.com/ubuntu-ports bionic main restricted universe multiverse"           >> /etc/apt/sources.list && \
    echo "deb [arch=armhf,arm64] http://ports.ubuntu.com/ubuntu-ports bionic-updates main restricted universe multiverse"   >> /etc/apt/sources.list && \
    echo "deb [arch=armhf,arm64] http://ports.ubuntu.com/ubuntu-ports bionic-backports main restricted universe multiverse" >> /etc/apt/sources.list

# update and upgrade system
RUN apt-get update && apt-get upgrade -qy && apt-get clean

# NOTE multiarch-support:armhf is installed but not multiarch-support:arm64, everything still works though

# install packages for buildroot
RUN apt-get install -qy multiarch-support:armhf qemu-user-static && \
    apt-get install -qy libmxml1:armhf libfftw3-3:armhf liblo7:armhf libsndfile1:armhf zlib1g:armhf libstdc++6:armhf && \
    apt-get install -qy libmxml1:arm64 libfftw3-3:arm64 liblo7:arm64 libsndfile1:arm64 zlib1g:arm64 libstdc++6:arm64 && \
    apt-get install -qy locales acl bash bash-completion bc curl cvs git mercurial rsync subversion sudo wget dosfstools && \
    apt-get install -qy bison bundler bzip2 cpio flex gawk gperf gzip help2man nano perl patch python tar texinfo unzip python3-dev python3-setuptools && \
    apt-get install -qy automake binutils build-essential device-tree-compiler premake4 sunxi-tools libtool-bin ncurses-dev libc6:i386 libstdc++6:i386 zlib1g:i386 jq && \
    apt-get install -qy libfreetype6-dev libx11-dev libxcursor-dev libxinerama-dev libxrandr-dev pkg-config && \
    apt-get clean
RUN wget http://archive.ubuntu.com/ubuntu/pool/universe/p/premake/premake_3.7-1_amd64.deb && \
    dpkg -i premake_3.7-1_amd64.deb && \
    rm premake_3.7-1_amd64.deb

RUN locale-gen en_US.UTF-8
RUN echo "source /etc/bash_completion" >> $HOME/.bashrc

# user configurations
ENV USER builder
ENV HOME /home/$USER

# mod-plugin-builder settings
ENV MPB_GIT_URL https://github.com/moddevices/mod-plugin-builder

# create user
RUN useradd -d $HOME -m -G sudo $USER
# set user to sudoers (no password required)
RUN echo "$USER ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/99-$USER && chmod 0440 /etc/sudoers.d/99-$USER

# switch user
USER $USER

# checkout mod-build-system
WORKDIR $HOME
RUN git clone $MPB_GIT_URL
WORKDIR mod-plugin-builder
RUN ./bootstrap.sh $platform && ./.clean-install.sh $platform

# CMD
CMD ["bash"]
