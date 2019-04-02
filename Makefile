.PHONEY: clean build storage image

clean:
	@rm -rf output-virtualbox-iso

build:
	@packer build -var iso_url=$(RHEL_IMAGE_PATH) -var iso_checksum=$(RHEL_IMAGE_CHECKSUM) -var rhn_username=$(RHN_USERNAME) -var rhn_password=$(RHN_PASSWORD) -var subscription_pool_id=$(RHEL_SUBSCRIPTION_POOL_ID) -force template.json

vhd:
	@vboxmanage clonehd --format VHD --variant Fixed "$(wildcard ./output-virtualbox-iso/*.vmdk)" "$(IMAGE_VHD_PATH)"

storage:
	@$(CURDIR)/utils/create-storage.sh

image:
	@$(CURDIR)/utils/upload-vmdisk.sh
