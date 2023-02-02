FROM ubuntu:22.04
LABEL maintainer="The Maintainer <maintainer@example.com>"

ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND noninteractive
ENV USER builder
ENV HOME /home/$USER

ARG REQUIRED_PKGS=" \
    bash bash-completion bc binutils bison build-essential bzip2 cpio cvs file flex gawk git help2man libtool-bin mercurial \
    ncurses-dev nano subversion pkg-config python3-dev python-is-python3 python3-setuptools rsync sudo tar texinfo unzip wget \
    "

RUN apt-get update && apt-get upgrade -qy && apt-get install -qy $REQUIRED_PKGS && apt-get clean && \
    useradd -d $HOME -m -G sudo $USER && echo "$USER ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/99-$USER && chmod 0440 /etc/sudoers.d/99-$USER && \
    echo "source /etc/bash_completion" >> $HOME/.bashrc

USER $USER
COPY . $HOME/mod-plugin-builder
WORKDIR $HOME/mod-plugin-builder

# Must not be named "PLATFORM" in order not to clash with buildroot.
ARG MPB_PLATFORM

# Below step is useful for debugging buildroot build failures,
# so it can be debugged without rebuilding the toolchain every time.
#RUN ./bootstrap.sh $MPB_PLATFORM toolchain

RUN ./bootstrap.sh $MPB_PLATFORM && ./.clean-install.sh $MPB_PLATFORM

CMD ["bash"]
