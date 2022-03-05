#!/bin/bash -e

echo "Installing openpilot dependencies"

# Add edge/testing repository
# TODO: remove once all packages are in main/community repositories
echo "https://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

apk update
apk add \
    alpine-sdk \
    autoconf \
    automake \
    bzip2-dev \
    capnproto \
    cargo \
    clang \
    clinfo \
    cmake \
    cppcheck \
    curl \
    curl-dev \
    czmq-dev \
    dbus-dev \
    eigen-dev \
    ffmpeg \
    freetype-dev \
    gcc-arm-none-eabi \
    glfw-dev \
    glib-dev \
    i2c-tools-dev \
    jpeg-dev \
    libarchive-dev \
    libass-dev \
    libbz2 \
    libffi-dev \
    libtool \
    libusb-dev \
    libuv-dev \
    libva-dev \
    libvdpau-dev \
    libvorbis-dev \
    libxcb-dev \
    opencl-headers \
    opencl-icd-loader-dev \
    openmp-dev \
    openssl-dev \
    rust \
    sdl2-dev \
    sqlite-dev \
    texinfo \
    wget \
    xz-dev \
    zeromq-dev \
    zlib-dev \
    mapbox-gl-qml \
    qt5-qtbase-dev \
    qt5-qtbase-sqlite \
    qt5-qtbase-x11 \
    qt5-qtdeclarative-dev \
    qt5-qtlocation-dev \
    qt5-qtmultimedia-dev \
    qt5-qtquickcontrols \
    qt5-qtwayland \
    qtchooser
