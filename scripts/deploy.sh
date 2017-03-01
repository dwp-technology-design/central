INSTANCE_ID=$(terraform output -state=./deploy/terraform.tfstate instance_id)
IP=$(terraform output -state=./deploy/terraform.tfstate ip)

echo "INSTANCE_ID=$INSTANCE_ID"
echo "INSTANCE_IP=$IP"

aws ec2 wait instance-status-ok --instance-ids $INSTANCE_ID
ssh -o "StrictHostKeyChecking=no" -t centos@${IP} 'sudo bash -s' < ./scripts/bootstrap.sh
ssh -o "StrictHostKeyChecking=no" -t centos@${IP} 'sudo bash -s' < ./scripts/install.sh
scp ./scripts/nexus.service centos@${IP}:/home/centos
scp ./scripts/nexus.vmoptions centos@${IP}:/home/centos
ssh -o "StrictHostKeyChecking=no" -t centos@${IP} 'sudo bash -s' < ./scripts/start.sh

