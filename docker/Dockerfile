FROM ubuntu:16.04
MAINTAINER Alexandre Cunha <alex@moddevices.com>
ENV DEBIAN_FRONTEND noninteractive

# enable armhf
RUN dpkg --add-architecture armhf

RUN echo "deb [arch=amd64] http://archive.ubuntu.com/ubuntu/ xenial main restricted universe multiverse"               > /etc/apt/sources.list && \
    echo "deb [arch=amd64] http://archive.ubuntu.com/ubuntu/ xenial-updates main restricted universe multiverse"      >> /etc/apt/sources.list && \
    echo "deb [arch=amd64] http://archive.ubuntu.com/ubuntu/ xenial-backports main restricted universe multiverse"    >> /etc/apt/sources.list && \
    echo "deb [arch=amd64] http://security.ubuntu.com/ubuntu xenial-security main restricted universe multiverse"     >> /etc/apt/sources.list && \
    echo "deb [arch=armhf] http://ports.ubuntu.com/ubuntu-ports xenial main restricted universe multiverse"           >> /etc/apt/sources.list && \
    echo "deb [arch=armhf] http://ports.ubuntu.com/ubuntu-ports xenial-updates main restricted universe multiverse"   >> /etc/apt/sources.list && \
    echo "deb [arch=armhf] http://ports.ubuntu.com/ubuntu-ports xenial-backports main restricted universe multiverse" >> /etc/apt/sources.list

# update and upgrade system
RUN apt-get update && apt-get upgrade -qy && apt-get clean

# install packages for buildroot
RUN apt-get install -qy multiarch-support:armhf libstdc++6:armhf qemu-user-static && \
    apt-get install -qy acl bash bash-completion bc curl cvs git mercurial rsync subversion sudo wget && \
    apt-get install -qy bison bzip2 flex gawk gperf gzip help2man nano perl patch tar texinfo unzip && \
    apt-get install -qy automake binutils build-essential cpio libtool-bin ncurses-dev pkg-config && \
    apt-get clean
RUN locale-gen en_US.UTF-8
RUN echo "source /etc/bash_completion" >> $HOME/.bashrc

# user configurations
ENV USER builder
ENV HOME /home/$USER

# mod-plugin-builder settings
ENV MPB_GIT_URL git://github.com/moddevices/mod-plugin-builder

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
RUN ./bootstrap.sh && ./.clean-install.sh

# CMD
CMD ["bash"]
