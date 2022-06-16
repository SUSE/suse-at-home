provider "aws" {
  region = var.region
}

resource "aws_instance" "nv-k3s" {
  count = var.cluster_count
  ami = var.aws_ami
  instance_type = var.aws_instance_type
  availability_zone = var.aws_az
  instance_initiated_shutdown_behavior = "terminate"
  vpc_security_group_ids = [var.aws_vpc_security_groups]
  subnet_id = var.aws_subnet_id
  user_data_base64 = base64encode(templatefile("${path.module}/cloud-init.tpl", {channel = var.k3s_channel, ssh_key = file(var.ssh_id), bootstrap_content = base64encode(file("${path.module}/bootstrap.sh"))}))

  root_block_device {
      volume_type = "gp2"
      volume_size = var.root_disk_size
  }

  tags = {
      Name = "neuvector-k3s-cluster-${count.index+1}"
  }

}
