REV:=$(shell git rev-parse --short HEAD)
DATE:=$(shell date +%Y.%m.%d-%H.%M.%S)
TAG:=$(DATE)-$(REV)
.PHONY: build test


validate:
        az login --service-principal --username "$azure_client_id" --password "$azure_client_secret" --tenant "$azure_tenant_id"
	az account set --subscription "$azure_subscription_id"
	az group create -l "${Location}" -n "${CustomerName}-RG"
	packer validate -var "resourcegroupname=${CustomerName}" -var "location=${Location}" -var "imagename=${CustomerName}$(TAG)" src/worker_template.json

build: validate 
        az login --service-principal --username "$azure_client_id" --password "$azure_client_secret" --tenant "$azure_tenant_id"
	az account set --subscription "$azure_subscription_id"
	packer build -var "resourcegroupname=${CustomerName}" -var "location=${Location}" -var "imagename=${CustomerName}$(TAG)"  src/worker_template.json
