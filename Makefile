REV:=$(shell git rev-parse --short HEAD)
DATE:=$(shell date +%Y.%m.%d-%H.%M.%S)
TAG:=$(DATE)-$(REV)
.PHONY: build test

# Tags
DOMAIN:=samya
AMI_ACCOUNTS:=322338739230

validate:
	packer validate src/worker_template.json

build: validate
	packer build -var "dest_ami_name=app-ami-$(TAG)" -var "domain=$(DOMAIN)" -var "git_sha=$(REV)" -var "ami_accounts=$(AMI_ACCOUNTS)"  src/worker_template.json

test:
	sh test/run.sh
