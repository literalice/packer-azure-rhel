#!/bin/bash -eux

az group create --name ${RESOURCE_GROUP} --location ${REGION}

az storage account create \
    --resource-group ${RESOURCE_GROUP} \
    --location ${REGION} \
    --name ${STORAGE_ACCOUNT_NAME} \
    --kind Storage \
    --sku Standard_LRS

az storage container create \
    --account-name ${STORAGE_ACCOUNT_NAME} \
    --name ${STORAGE_CONTAINER_NAME}
