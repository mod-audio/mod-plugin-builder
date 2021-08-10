FROM ubuntu:20.04
LABEL maintainer="Filipe Coelho <falktx@falktx.com>"
ENV DEBIAN_FRONTEND noninteractive

# platform argument must be provided, e.g. --build-arg platform=modduo
ARG platform=moddwarf

# enable armhf
RUN dpkg --add-architecture armhf

RUN echo "deb [arch=armhf,arm64] http://ports.ubuntu.com/ubuntu-ports focal main restricted universe multiverse"            > /etc/apt/sources.list && \
    echo "deb [arch=armhf,arm64] http://ports.ubuntu.com/ubuntu-ports focal-updates main restricted universe multiverse"   >> /etc/apt/sources.list && \
    echo "deb [arch=armhf,arm64] http://ports.ubuntu.com/ubuntu-ports focal-backports main restricted universe multiverse" >> /etc/apt/sources.list

# update and upgrade system
RUN apt-get update && apt-get upgrade -qy && apt-get clean

# install packages for buildroot
RUN apt-get install -qy qemu-user-static && \
    apt-get install -qy libmxml1:armhf libfftw3-3:armhf liblo7:armhf libsndfile1:armhf zlib1g:armhf libstdc++6:armhf && \
    apt-get install -qy libmxml1:arm64 libfftw3-3:arm64 liblo7:arm64 libsndfile1:arm64 zlib1g:arm64 libstdc++6:arm64 && \
    apt-get install -qy locales acl bash bash-completion bc curl cvs git mercurial rsync subversion sudo wget dosfstools && \
    apt-get install -qy bison bundler bzip2 cpio flex gawk gperf gzip help2man nano perl patch python tar texinfo unzip python3-dev python3-setuptools && \
    apt-get install -qy automake binutils build-essential device-tree-compiler premake4 sunxi-tools libtool-bin ncurses-dev jq && \
    apt-get install -qy libfreetype6-dev libx11-dev libxcursor-dev libxinerama-dev libxrandr-dev pkg-config && \
    apt-get clean
RUN wget http://ports.ubuntu.com/ubuntu-ports/pool/universe/p/premake/premake_3.7-1_arm64.deb && \
    dpkg -i premake_3.7-1_arm64.deb && \
    rm premake_3.7-1_arm64.deb

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
