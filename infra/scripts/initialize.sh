#!/bin/bash

# This script creates the necessary resources in Azure for Terraform to run. Execute az login before running this script.

# names must match the names in providers.tf
RG_NAME="rg-streamlit-poc"
SA_NAME="streamlittfstate"
CONTAINER_NAME="tfstate"
LOCATION="westeurope"
APP_REG_NAME="sp-streamlit-poc"

echo "Create resource group"
# check if the resource group already exists
if [[ $(az group exists -n $RG_NAME) == "false" ]]; then
  # create a resource group
  echo "Creating resource group $RG_NAME in location $LOCATION"
  az group create -n $RG_NAME -l $LOCATION
fi

echo "Create storage account"
# check if the storage account already exists
if [[ $(az storage account check-name --name $SA_NAME --query nameAvailable -o tsv) == "true" ]]; then
  # create a storage account for storing terraform state
  echo "Creating storage account $SA_NAME in resource group $RG_NAME"
  az storage account create -n $SA_NAME -g $RG_NAME -l $LOCATION --sku Standard_LRS
fi

STORAGE_KEY=$(az storage account keys list -g $RG_NAME -n $SA_NAME --query "[0].value" -o tsv)

echo "Create storage container"
# check if the container already exists
if [[ $(az storage container exists -n $CONTAINER_NAME --account-name $SA_NAME --account-key $STORAGE_KEY --query exists -o tsv) == "false" ]]; then
  # create a container
  echo "Creating storage container $CONTAINER_NAME in storage account $SA_NAME"
  az storage container create -n $CONTAINER_NAME --account-name $SA_NAME --account-key $STORAGE_KEY
fi

echo "Create app registration"
# check if the app registration already exists
if [[ -z $(az ad app list --display-name $APP_REG_NAME --query "[0].appId" -o tsv) ]]; then
  # create app reg
  az ad app create --display-name $APP_REG_NAME
fi

# get the app reg id
APP_REG_ID=$(az ad app list --display-name $APP_REG_NAME --query "[0].appId" -o tsv)
# get the tenant id
TENANT_ID=$(az account show --query "tenantId" -o tsv)
# get the subscription id
SUB_ID=$(az account show --query "id" -o tsv)
# get the resource group id
RG_ID=$(az group show --name $RG_NAME --query id --output tsv)

echo "Create service principal credentials"
# check if the service principal already exists
if [[ -z $(az ad sp list --display-name $APP_REG_NAME --query "[0].appId" -o tsv) ]]; then
  az ad sp create --id $APP_REG_ID
fi

echo "Create federated credentials"
# check if the federated credentials already exist
if [[ -z $(az ad app federated-credential list --id $APP_REG_ID --query "[0].id" -o tsv) ]]; then
  # create federated credentials
  az ad app federated-credential create --id $APP_REG_ID --parameters credential.json
fi

# Echo details
echo "Details needed for Github Secrets"
echo "- ClientID=$APP_REG_ID"
echo "- Tenant_ID=$TENANT_ID"
echo "- Subscription_ID=$SUB_ID"