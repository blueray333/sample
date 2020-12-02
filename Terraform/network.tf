resource "aws_internet_gateway" "my-gateway" {
    vpc_id = "${aws_vpc.my-vpc.id}"
    tags {
        Name = "my-gateway"
    }
}


resource "aws_route_table" "my-route-table" {
    vpc_id = "${aws_vpc.main-vpc.id}"
    
    route {
        cidr_block = "0.0.0.0/0" 
        gateway_id = "${aws_internet_gateway.my-gateway.id}" 
    }
    
    tags {
        Name = "my-route-table"
    }
}

resource "aws_route_table_association" "my-crta-public-subnet"{
    subnet_id = "${aws_subnet.my-subnet.id}"
    route_table_id = "${aws_route_table.my-route-table.id}"
}

resource "aws_security_group" "my-ssh-allowed" {
    vpc_id = "${aws_vpc.my-vpc.id}"
    
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"] //replace with office ip
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags {
        Name = "my-ssh-allowed"
    }
}