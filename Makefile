.PHONY: deploy destroy

PUBLIC_KEY_PATH="/home/vagrant/.ssh/id_rsa_central.pub"
KEY_NAME="central"
AMI="ami-f4634d92"
#
# BASE CENT OS
#AMI="ami-7abd0209"
REGION="eu-west-1"

ips:
	terraform output -state=./deploy/terraform.tfstate ip

validate:
	terraform validate ./deploy

deploy: validate
	cd deploy && \
	terraform apply -var "key_name=$(KEY_NAME)" -var "public_key_path=$(PUBLIC_KEY_PATH)" -var "aws_region=$(REGION)" -var "aws_ami=$(AMI)"
	bash ./scripts/deploy.sh


destroy: validate
	(cd deploy && \
	terraform destroy -var "key_name=$(KEY_NAME)" -var "public_key_path=$(PUBLIC_KEY_PATH)" -var "aws_region=$(REGION)" -var "aws_ami=$(AMI)")
