INSTANCE_ID=$(terraform output -state=./deploy/terraform.tfstate instance_id)
IP=$(terraform output -state=./deploy/terraform.tfstate ip)

echo "INSTANCE_ID=$INSTANCE_ID"
echo "INSTANCE_IP=$IP"

aws ec2 wait instance-status-ok --instance-ids $INSTANCE_ID

scp -o "StrictHostKeyChecking=no" ./scripts/* centos@${IP}:/home/centos

ssh -o "StrictHostKeyChecking=no" -t centos@${IP} 'sudo bash run.sh'

