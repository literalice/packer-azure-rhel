# RHEL7 Pakcer template and uploader for Azure

## Prerequisites

* Packer
* Virtualbox
* make

## Configure

```bash
# RHEL7 Binary Image
export RHEL_IMAGE_CHECKSUM=60a0be5aeed1f08f2bb7599a578c89ec134b4016cd62a8604b29f15d543a469c
export RHEL_IMAGE_PATH="$(pwd)/iso/rhel-server-7.6-x86_64-dvd.iso"

# RHEL Subscription information
export RHEL_SUBSCRIPTION_POOL_ID=xxx
export RHN_USERNAME=xxx
export RHN_PASSWORD=xxx

# Azure Information
export REGION=japaneast
export RESOURCE_GROUP=vmimages

export IMAGE_VHD_NAME=rhel76.vhd
export IMAGE_VHD_PATH="$(pwd)/output-virtualbox-iso/${IMAGE_VHD_NAME}"
export STORAGE_ACCOUNT_NAME=vmimages
export STORAGE_CONTAINER_NAME=vhd
export IMAGE_NAME=rhel-76-1
```

## Usage

### Creates VHD of RHEL

```bash
make build
make vhd
```

### Creates Storage Account for Azure

If there is no strage account for upload vhd, run this:

```bash
make storage
```

### Uploads VHD and creates managed disk, VM image for Azure

```
make image
```
