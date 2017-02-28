# Specify the provider and access details
provider "aws" {
   region = "${var.aws_region}"
}

# Create a VPC to launch our instances into
resource "aws_vpc" "central" {
  cidr_block = "10.0.0.0/16"
}

# Create an internet gateway to give our subnet access to the outside world
resource "aws_internet_gateway" "central" {
  vpc_id = "${aws_vpc.central.id}"
}

# Grant the VPC internet access on its main route table
resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.central.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.central.id}"
}

# Create a subnet to launch our instances into
resource "aws_subnet" "central" {
  vpc_id                  = "${aws_vpc.central.id}"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
}


# Our default security group to access
# the instances over SSH and HTTP
resource "aws_security_group" "central" {
  name        = "central"
  description = "Used in the terraform"
  vpc_id      = "${aws_vpc.central.id}"

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "auth" {
  key_name   = "${var.key_name}"
  public_key = "${file(var.public_key_path)}"
}

resource "aws_instance" "rpm_repository" {
  # The connection block tells our provisioner how to
  # communicate with the resource (instance)
  connection {
    # The default username for our AMI
    user = "centos"

    # The connection will use the local SSH agent for authentication.
  }

  instance_type = "t2.micro"

  tags {
    Name = "central-rpm-repository"
  }

  # Lookup the correct AMI based on the region
  # we specified
  # ami = "${lookup(var.aws_amis, var.aws_region)}"
  ami = "${var.aws_ami}"

  # The name of our SSH keypair we created above.
  key_name = "${aws_key_pair.auth.id}"

  # Our Security group to allow HTTP and SSH access
  vpc_security_group_ids = ["${aws_security_group.central.id}"]

  # We're going to launch into the same subnet as our ELB. In a production
  # environment it's more common to have a separate private subnet for
  # backend instances.
  subnet_id = "${aws_subnet.central.id}"
}
