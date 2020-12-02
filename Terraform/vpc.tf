provider "aws" {
  version = "~> 2.0"
  region     = var.region
}

resource “aws_vpc” “my-vpc” {
    cidr_block = “10.0.0.0/16”
    enable_dns_support = “true”
    enable_dns_hostnames = “true”
    instance_tenancy = “default”    
    
    tags {
        Name = “my-vpc”
    }
}

resource “aws_subnet” “my-subnet” {
    vpc_id = "${aws_vpc.My_VPC.id}"
    cidr_block = “10.0.1.0/24”
    map_public_ip_on_launch = “true”
    availability_zone = var.availabilityZone
    tags {
        Name = “my-subnet”
    }
}


resource "aws_instance" "web" {
    count = 2;       
    ami = data.aws_ami.ubuntu.id
    instance_type = "t2.micro"
    subnet_id = aws_subnet.My_Subnet.id
    connection {
        user = "${var.EC2_USER}"
        private_key = "${file("${var.PRIVATE_KEY_PATH}")}"
    }
}

resource "aws_instance" "web" {
    count = 2; 
    ami = "${lookup(var.AMI, var.region)}"
    instance_type = "t2.micro"
    # VPC
    subnet_id = "${aws_subnet.my-subnet.id}"
    # Security Group
    vpc_security_group_ids = ["${aws_security_group.my-ssh-allowed.id}"]
    # the Public SSH key
    key_name = "${aws_key_pair.my-region.id}"
    # nginx installation
    provisioner "file" {
        source = "nginx.sh"
        destination = "/tmp/nginx.sh"
    }
    provisioner "remote-exec" {
        inline = [
             "chmod +x /tmp/nginx.sh",
             "sudo /tmp/nginx.sh"
        ]
    }
    connection {
        user = "${var.EC2_USER}"
        private_key = "${file("${var.PRIVATE_KEY_PATH}")}"
    }

    tags = {
        name = "web-${count.index + 1}"
    }	
}

resource "aws_key_pair" "my-region" {
    key_name = my-region"
    public_key = "${file(var.PUBLIC_KEY_PATH)}"
}
