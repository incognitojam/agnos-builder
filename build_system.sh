#!/bin/bash -e

ALPINE_BASE_URL="https://dl-cdn.alpinelinux.org/alpine/v3.15/releases/aarch64"
ALPINE_FILE="alpine-minirootfs-3.15.0-aarch64.tar.gz"

# Make sure we're in the correct spot
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null && pwd)"
cd $DIR

BUILD_DIR="$DIR/build"
OUTPUT_DIR="$DIR/output"

ROOTFS_DIR="$BUILD_DIR/agnos-rootfs"
ROOTFS_IMAGE="$BUILD_DIR/system.img.raw"
ROOTFS_IMAGE_SIZE=10G
SPARSE_IMAGE="$BUILD_DIR/system.img"

# Create temp dir if non-existent
mkdir -p $BUILD_DIR $OUTPUT_DIR

# Download Alpine rootfs if not done already
if [ ! -f $ALPINE_FILE ]; then
  echo -e "${GREEN}Downloading Alpine: $ALPINE_FILE ${NO_COLOR}"
  wget -c $ALPINE_BASE_URL/$ALPINE_FILE --quiet
  wget -c $ALPINE_BASE_URL/$ALPINE_FILE.sha256 --quiet
  if [ ! echo "$(cat $ALPINE_FILE.sha256) $ALPINE_FILE" | sha256sum --check --status ]; then
    echo -e "${RED}Downloaded Alpine rootfs does not match checksum${NO_COLOR}"
    exit 1
  fi
fi

# TODO: this needs to be re-done sometimes
# Register qemu multiarch if not done
if [ ! -f $DIR/.qemu_registered ] && [ "$(uname -p)" != "aarch64" ]; then
  docker run --rm --privileged multiarch/qemu-user-static:register
  touch $DIR/.qemu_registered
fi

# Start docker build
echo "Building image"
export DOCKER_CLI_EXPERIMENTAL=enabled
docker build -f Dockerfile.agnos -t agnos-builder $DIR

echo "Done!"

# # Create filesystem ext4 image
# echo "Creating empty filesystem"
# fallocate -l $ROOTFS_IMAGE_SIZE $ROOTFS_IMAGE
# mkfs.ext4 $ROOTFS_IMAGE > /dev/null

# # Mount filesystem
# echo "Mounting empty filesystem"
# mkdir -p $ROOTFS_DIR
# sudo umount -l $ROOTFS_DIR > /dev/null || true
# sudo mount $ROOTFS_IMAGE $ROOTFS_DIR

# # Extract image
# echo "Extracting docker image"
# CONTAINER_ID=$(docker container create --entrypoint /bin/bash agnos-builder:latest)
# docker container export -o $BUILD_DIR/filesystem.tar $CONTAINER_ID
# docker container rm $CONTAINER_ID > /dev/null
# cd $ROOTFS_DIR
# sudo tar -xf $BUILD_DIR/filesystem.tar > /dev/null

# # Add hostname and hosts. This cannot be done in the docker container...
# echo "Setting network stuff"
# HOST=tici
# sudo bash -c "echo $HOST > etc/hostname"
# sudo bash -c "echo \"127.0.0.1    localhost.localdomain localhost\" > etc/hosts"
# sudo bash -c "echo \"127.0.0.1    $HOST\" >> etc/hosts"

# # Fix resolv config
# sudo bash -c "ln -sf /run/systemd/resolve/stub-resolv.conf etc/resolv.conf"

# cd $DIR

# # Unmount image
# echo "Unmount filesystem"
# sudo umount -l $ROOTFS_DIR

# # Sparsify
# echo "Sparsify image"
# img2simg $ROOTFS_IMAGE $SPARSE_IMAGE
# mv $SPARSE_IMAGE $OUTPUT_DIR

# echo "Done!"
