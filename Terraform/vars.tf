variable "region" {
     default = "us-east-1"
}
variable "availabilityZone" {
     default = "us-east-1a"
}

variable "AMI" {
    type = "map"
    
    default {
        us-east-1 = "ami-022758574f5a26580"
    }
}
