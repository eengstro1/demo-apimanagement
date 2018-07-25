#!/usr/bin/env bash
#
#  Purpose: Initialize the template load for testing purposes
#  Usage:
#    install.sh <resourcegroup> <publishername> <email>


###############################
## ARGUMENT INPUT            ##
###############################
usage() { echo "Usage: install.sh <email> <resourcegroup> <prefix> <publishername>" 1>&2; exit 1; }

if [ ! -z $1 ]; then PUBLISHER_EMAIL=$1; fi
if [ -z $PUBLISHER_EMAIL ]; then
  tput setaf 1; echo 'ERROR: PUBLISHER_EMAIL not provided' ; tput sgr0
  usage;
fi

if [ ! -z $2 ]; then RESOURCE_GROUP=$2; fi
if [ -z $RESOURCE_GROUP ]; then
  RESOURCE_GROUP="demo-apimanagement"
fi

if [ ! -z $3 ]; then PREFIX=$3; fi
if [ -z $PREFIX ]; then
  PREFIX="75098"
fi

if [ ! -z $4 ]; then PUBLISHER_NAME=$4; fi
if [ -z $PUBLISHER_NAME ]; then
  PUBLISHER_NAME="danielscholl"
fi


###############################
## FUNCTIONS                 ##
###############################
function CreateResourceGroup() {
  # Required Argument $1 = RESOURCE_GROUP
  # Required Argument $2 = LOCATION

  if [ -z $1 ]; then
    tput setaf 1; echo 'ERROR: Argument $1 (RESOURCE_GROUP) not received'; tput sgr0
    exit 1;
  fi
  
  if [ -z $2 ]; then
    tput setaf 1; echo 'ERROR: Argument $2 (LOCATION) not received'; tput sgr0
    exit 1;
  fi

  local _result=$(az group show --name $1)
  if [ "$_result"  == "" ]
    then
      OUTPUT=$(az group create --name $1 \
        --location $2 \
        -ojsonc)
    else
      tput setaf 3;  echo "Resource Group $1 already exists."; tput sgr0
    fi
}

###############################
## Azure Intialize           ##
###############################

tput setaf 2; echo 'Creating Resource Group...' ; tput sgr0
CreateResourceGroup $RESOURCE_GROUP eastus2

##############################
## Deploy Template          ##
##############################
BASE_DIR=$PWD
CODE="https://github.com/danielscholl/demo-apimanagement-funcapp.git"

tput setaf 2; echo "Deploying Container Instance..." ; tput sgr0
az container create --name "${PREFIX}-api" \
--resource-group ${RESOURCE_GROUP} \
--image "${PUBLISHER_NAME}/demoapi" \
--dns-name-label "${PREFIX}-api" \
--ports 80

tput setaf 2; echo "Deploying Storage Account..." ; tput sgr0
az storage account create --name "${PREFIX}storage" \
    --resource-group ${RESOURCE_GROUP} \
    --sku Standard_LRS \
    --location eastus2

tput setaf 2; echo "Deploying Function App..." ; tput sgr0
az functionapp create --name "${PREFIX}-funcapp" \
    --resource-group ${RESOURCE_GROUP} \
    --storage-account  "${PREFIX}storage" \
    --deployment-source-url ${CODE}  \
    --consumption-plan-location eastus2

az functionapp config appsettings set --name "${PREFIX}-funcapp" \
    --resource-group ${RESOURCE_GROUP} \
    --settings FUNCTIONS_EXTENSION_VERSION=beta

tput setaf 2; echo "Deploying API Management..." ; tput sgr0
az group deployment create \
  --template-file $BASE_DIR/templates/azuredeploy.json \
  --parameters $BASE_DIR/templates/azuredeploy.parameters.json \
  --parameters publisherName=$PUBLISHER_NAME publisherEmail=$PUBLISHER_EMAIL \
  --resource-group $RESOURCE_GROUP


