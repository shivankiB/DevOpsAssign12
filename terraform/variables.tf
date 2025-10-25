variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "ubuntu_ami" {
  type    = string
  # Replace with a valid Ubuntu 20.04 AMI for your region if needed
  default = "ami-0360c520857e3138f"
}

# If you already have a key pair in AWS and want Terraform to use it:
variable "existing_key_name" {
  type    = string
  default = "terraform-key" 
}
