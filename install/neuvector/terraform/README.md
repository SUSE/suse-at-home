From https://github.com/ibrokethecloud/neuvector-k3s-quickstart

# Terraform module to launch NeuVector v5.0 on AWS

This terraform module will launch a SLES15 SP3 CHOST image on AWS (US-East1 by default), install K3s and NeuVector v5.0 on the single node.

To get started you need: 
 - Your AWS VPC security group
 - Your AWS VPC subnet id
 - All others are sane defaults (region, ssh key location, etc)

Be sure to copy the terraform.tfvars.sample to terraform.tfvars and change the AWS VPC security group and the AWS subnet ID to get started.

Then run terraform init, terraform apply to get started.
You can use terraform show to get the public IP
The Neuvector ingress will be exposed at `neuvector.${PUBLIC_ADDRESS}.sslip.io`


Some of the inputs required are as follows:

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_ami"></a> [aws\_ami](#input\_aws\_ami) | n/a | `string` | n/a | yes |
| <a name="input_aws_az"></a> [aws\_az](#input\_aws\_az) | n/a | `string` | `"ap-southeast-2a"` | no |
| <a name="input_aws_instance_type"></a> [aws\_instance\_type](#input\_aws\_instance\_type) | n/a | `string` | `"t3.xlarge"` | no |
| <a name="input_aws_subnet_id"></a> [aws\_subnet\_id](#input\_aws\_subnet\_id) | n/a | `string` | n/a | yes |
| <a name="input_aws_vpc_security_groups"></a> [aws\_vpc\_security\_groups](#input\_aws\_vpc\_security\_groups) | n/a | `string` | n/a | yes |
| <a name="input_cluster_count"></a> [cluster\_count](#input\_cluster\_count) | n/a | `number` | `"1"` | no |
| <a name="input_k3s_channel"></a> [k3s\_channel](#input\_k3s\_channel) | n/a | `string` | `"v1.20"` | no |
| <a name="input_root_disk_size"></a> [root\_disk\_size](#input\_root\_disk\_size) | n/a | `number` | `"50"` | no |
| <a name="input_ssh_id"></a> [ssh\_id](#input\_ssh\_id) | n/a | `string` | n/a | yes |