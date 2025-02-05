# Specify Packer version
packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = ">= 1.0.0"
    }
  }
}

# Define the AWS Builder
source "amazon-ebs" "ubuntu" {
  ami_name      = "ami-ubuntu"
  region        = "us-west-2"
  source_ami    = "ami-00c257e12d6828491" # Ubuntu 20.04 in us-west-2
  instance_type = "t2.micro"
  ssh_username  = "ubuntu"
}

# Provisioning: Install basic packages
build {
  sources = ["source.amazon-ebs.ubuntu"]

  provisioner "shell" {
    inline = [
      "sudo apt update",
      "sudo apt install -y nginx"
    ]
  }
}
