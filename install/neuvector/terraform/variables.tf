variable region {
    type = string
    default = "us-east-1"
}

variable cluster_count {
    type = number
    default = "1"
}

variable k3s_channel {
    type = string
    default = "v1.20"
}

variable ssh_id {
    type = string
}

variable aws_ami {
    type = string
}

variable aws_az {
    type = string
    default = "us-east-1a"
}

variable aws_vpc_security_groups {
    type = string
}

variable aws_subnet_id {
    type = string
}

variable root_disk_size {
    type = number
    default = "50"
}

variable aws_instance_type {
    type = string
    default = "t3.xlarge"
}
