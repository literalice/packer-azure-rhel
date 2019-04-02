#!/bin/bash -eux

STORAGE_KEY=$(az storage account keys list --account-name=${STORAGE_ACCOUNT_NAME} --query='[0].value')
STORAGE_KEY=$(echo ${STORAGE_KEY} | sed 's/^"\(.*\)"$/\1/')

az storage blob upload --account-name ${STORAGE_ACCOUNT_NAME} \
    --account-key ${STORAGE_KEY} \
    --container-name ${STORAGE_CONTAINER_NAME} \
    --type page \
    --file ${IMAGE_VHD_PATH} \
    --name ${IMAGE_VHD_NAME}

az disk create \
    --resource-group ${RESOURCE_GROUP} \
    --name ${IMAGE_NAME} \
    --sku Standard_LRS \
    --os-type Linux \
    --source https://${STORAGE_ACCOUNT_NAME}.blob.core.windows.net/${STORAGE_CONTAINER_NAME}/${IMAGE_VHD_NAME}

az image create -n ${IMAGE_NAME} --source ${IMAGE_NAME} -g ${RESOURCE_GROUP} --os-type Linux

az disk delete -y -n ${IMAGE_NAME} --resource-group ${RESOURCE_GROUP}