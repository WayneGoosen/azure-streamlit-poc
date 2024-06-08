#!/bin/bash

# names must match the names in providers.tf
RG_NAME="rg-streamlit"
SA_NAME="streamlittfstate"
CONTAINER_NAME="tfstate"
APP_REG_NAME="streamlit-app-reg"

# get the app reg id
APP_REG_ID=$(az ad app list --display-name $APP_REG_NAME --query "[0].appId" -o tsv)

# delete app registration
az ad app delete --id $APP_REG_ID

# delete resource group
az group delete -n $RG_NAME --yes --no-wait