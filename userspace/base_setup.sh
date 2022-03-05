#!/bin/ash -e

USERNAME=comma
PASSWD=comma
HOST=tici

# Create identification file
touch /TICI

# Install necessary packages
apk update
apk add bash shadow sudo

# Create privileged user
adduser --shell /bin/bash --disabled-password $USERNAME
(echo $USERNAME; echo $PASSWD) | passwd
addgroup gpio
addgroup gpu
addgroup $USERNAME root
addgroup $USERNAME video
addgroup $USERNAME gpio
addgroup $USERNAME adm
addgroup $USERNAME gpu
addgroup $USERNAME audio
addgroup $USERNAME disk
addgroup $USERNAME wheel

# Add armhf as supported architecture
# TODO: do we need similar for alpine?
# dpkg --add-architecture armhf

# Install packages
# TODO: we don't have systemd, locales is probably different too
# export DEBIAN_FRONTEND=noninteractive
# apt-get update
# apt-get install -yq locales systemd
# adduser $USERNAME systemd-journal

# Enable serial console on UART
# TODO: fix for alpine
# systemctl enable serial-getty@ttyS0.service

# set kernel params
# TODO: kernel params for alpine
# echo "net.ipv4.conf.all.rp_filter = 2" >> /etc/sysctl.conf
# echo "vm.dirty_expire_centisecs = 200" >> /etc/sysctl.conf

# raise comma user's process priority limits
# TODO: fix process priority limits for alpine
# echo "$USERNAME - rtprio 100" >> /etc/security/limits.conf
# echo "$USERNAME - nice -10" >> /etc/security/limits.conf

# Locale setup
# TODO: fix locales for alpine
# locale-gen en_US.UTF-8
# update-locale LANG=en_US.UTF-8

apk update
apk add \
    alpine-sdk \
    alsa-utils \
    bc \
    bzip2 \
    curl \
    chrony \
    evtest \
    git \
    git-lfs \
    gdb \
    htop \
    i2c-tools \
    ifupdown \
    jq \
    libtool \
    libffi-dev \
    llvm \
    nano \
    net-tools \
    nload \
    nvme-cli \
    openssl \
    smartmontools \
    speedtest-cli \
    sshfs \
    sudo \
    tmux \
    tk-dev \
    udev \
    wget \
    wireless-tools
# apport-retrace \
# build-essential \
# cpuset \
# dfu-util \
# git-core \
# ifmetric \
# landscape-common \
# libc6-dev \
# libgdbm-dev \
# libi2c-dev \
# libncursesw5-dev \
# libqmi-utils \
# libsqlite3-dev \
# libssl-dev \
# network-manager \
# python-dev \
# python-setuptools \
# ssh \
# traceroute \
# udhcpc \
# zlib1g-dev

# TODO: cleanup
# rm -rf /var/lib/apt/lists/*

# Allow chrony to make a big adjustment to system time on boot
# TODO: do we need this for alpine?
# echo "makestep 0.1 3" >> /etc/chrony/chrony.conf

# Create dirs
mkdir /data && chown $USERNAME:$USERNAME /data
mkdir /persist && chown $USERNAME:$USERNAME /persist

# Disable automatic ondemand switching from ubuntu
# TODO: no systemd
# systemctl disable ondemand

# Disable pstore service that moves files out of /sys/fs/pstore
# TODO: no systemd
# systemctl disable systemd-pstore.service

# Nopasswd sudo
echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/wheel

# setup /bin/sh symlink
# TODO: not sure why we do this
ln -sf /bin/bash /bin/sh

# Install neccesary libs
# TODO
# apk update
# apk add \
#     libacl1:armhf \
#     libasan2-armhf-cross \
#     libatomic1-armhf-cross \
#     libattr1:armhf \
#     libaudit1:armhf \
#     libblkid1:armhf \
#     libc6:armhf \
#     libc6-armhf-cross \
#     libc6-dev:armhf \
#     libc6-dev-armhf-cross \
#     libcairo2:armhf \
#     libcap2:armhf \
#     libdrm2:armhf \
#     libevdev2:armhf \
#     libexpat1:armhf \
#     libffi6:armhf \
#     libfontconfig1:armhf \
#     libfreetype6:armhf \
#     libgbm1:armhf \
#     libgcc-5-dev-armhf-cross \
#     libgcc1:armhf \
#     libglib2.0-0:armhf \
#     libgomp1-armhf-cross \
#     libgudev-1.0-0:armhf \
#     libinput-bin:armhf \
#     libinput-dev:armhf \
#     libinput10:armhf \
#     libjpeg-dev:armhf \
#     libjpeg-turbo8:armhf \
#     libjpeg-turbo8-dev:armhf \
#     libjpeg8:armhf \
#     libjpeg8-dev:armhf \
#     libkmod2:armhf \
#     libmtdev1:armhf \
#     libpam0g:armhf \
#     libpam0g-dev:armhf \
#     libpcre3:armhf \
#     libpixman-1-0:armhf \
#     libpng16-16:armhf \
#     libselinux1:armhf \
#     libstdc++6:armhf \
#     libstdc++6-armhf-cross \
#     libubsan0-armhf-cross \
#     libudev-dev:armhf \
#     libudev1:armhf \
#     libuuid1:armhf \
#     libwacom2:armhf \
#     libwayland-client0:armhf \
#     libwayland-cursor0:armhf \
#     libwayland-server0:armhf \
#     libx11-6:armhf \
#     libxau6:armhf \
#     libxcb-render0:armhf \
#     libxcb-shm0:armhf \
#     libxcb1:armhf \
#     libxdmcp6:armhf \
#     libxext6:armhf \
#     libxkbcommon0:armhf \
#     libxrender1:armhf \
#     linux-libc-dev:armhf \
#     linux-libc-dev-armhf-cross \
#     zlib1g:armhf \
#     libegl1 \
#     libegl-dev \
#     libgles1 \
#     libgles2 \
#     libgles-dev \
#     libwayland-dev \
#     pulseaudio \
#     pulseaudio-utils \
#     openssh-server \
#     dnsmasq-base \
#     isc-dhcp-client \
#     iputils-ping \
#     rsyslog \
#     kmod \
#     wpasupplicant \
#     hostapd \
#     libgtk2.0-dev \
#     libcap2:armhf \
#     libxml2:armhf \
