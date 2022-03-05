# Dependencies

Recreating the agnos userspace in alpine...

---

## System packages

Alpine Linux packages are installed using the `apk` tool.

### Added packages

Required for building `casadi` from source:
- `protobuf-dev`, `protobuf-c-dev`
- `swig`

```
/tmp/casadi-ge6/build # cmake .. \
>     -DWITH_PYTHON=ON \
>     -DWITH_EXAMPLES=OFF \
>     -DCMAKE_INSTALL_PREFIX:PATH=$VENV \
>     -DPYTHON_PREFIX:PATH=$VENV/lib/python$PYTHON_VER/site-packages \
>     -DPYTHON_LIBRARY:FILEPATH=/usr/local/pyenv/versions/3.8.10/lib/libpython3.8.a \
>     -DPYTHON_EXECUTABLE:FILEPATH=/usr/local/pyenv/versions/3.8.10/bin/python \
>     -DPYTHON_INCLUDE_DIR:PATH=/usr/local/pyenv/versions/3.8.10/include/python3.8 \
>     -DCMAKE_CXX_FLAGS="" -DCMAKE_C_FLAGS=""
```

Required for installing `cryptography` python package:
- `cargo`
- `rust`

### Renamed packages

These packages are thought to be identical to their debian counterparts.

- `libbz2-dev` -> `bzip2-dev`
- `libcurl4-openssl-dev` -> `curl-dev`
- `libczmq-dev` -> `czmq-dev`
- `libdbus-1-dev` -> `dbus-dev`
- `libeigen3-dev` -> `eigen-dev`
- `libfreetype6-dev` -> `freetype-dev`
- `libglfw3-dev` -> `glfw-dev`
- `libglib2.0-0` -> `glib-dev`
- `libi2c-dev` -> `i2c-tools-dev`
- `libjpeg-dev` -> `jpeg-dev`
- `liblzma-dev` -> `xz-dev`
- `libomp-dev` -> `openmp-dev`
- `libsdl2-dev` -> `sdl2-dev`
- `libsqlite3-dev` -> `sqlite-dev`
- `libssl-dev` -> `openssl-dev`
- `libusb-1.0-0-dev` -> `libusb-dev`
- `libuv1-dev` -> `libuv-dev`
- `libxcb1-dev`, `libxcb-xfixes0-dev`, `libxcb-shm0-dev` -> `libxcb-dev`
- `libzmq3-dev` -> `zeromq-dev`
- `ocl-icd-libopencl1`, `ocl-icd-opencl-dev` -> `opencl-icd-loader-dev`
- `zlib1g-dev` -> `zlib-dev`

#### Qt packages

- `libqt5location5-plugin-mapboxgl`, (mapbox-gl-native)
  - We are using `mapbox-gl-qml`, but could try `mapbox-gl-native-dev`?
- `libqt5opengl5-dev` -> `qt5-qtbase-x11`
- `libqt5sql5-sqlite` -> `qt5-qtbase-sqlite`
- `libqt5svg5-dev` -> `qt5-qtsvg-dev`
- `qml-module-qtquick2` -> `qt5-qtquickcontrols`
- `qt5-default` -> `qtchooser`
- `qtbase5-private-dev `-> `qt5-qtbase-dev`
- `qtdeclarative5-dev`, `qtdeclarative5-private-dev` -> `qt5-qtdeclarative-dev`
- `qtmultimedia5`, `libqt5multimedia5-plugins` -> `qt5-qtmultimedia-dev`
- `qtlocation5-dev`, `qtpositioning5-dev` -> `qt5-qtlocation-dev`
- `qtwayland5` -> `qt5-qtwayland`

#### Notes on version mismatches

The following packages were built from source before, but we are just using the packages available in the repository instead.

- `capnproto`, using `0.8.0-r1` not `0.8.0`
- `ffmpeg`, using `4.4.1-r2` not `4.2.2`

### Testing packages

These packages can only be installed when you include the edge/testing repository. Once they move out of edge, we can remove the line which adds the testing repository in `openpilot_dependencies.sh`.

- `clinfo`
- `openmp-dev`

### Removed packages

- `libsystemd-dev` - systemd isn't available
- `locales` - it might not be needed?
- `pkg-config` (TODO: `pkgconf` might be alternative?)

### Missing packages

- `casync` - this isn't available in the alpine package repository, though I think it is only used for the agnos updater.

---

## Python dependencies

Some python packages are seemingly not available in this environment:

- `casadi` does not install
