terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3"
    }
  }
}

provider "aws" {
  profile = "default"
  region = "us-west-2"
}

resource "aws_appmesh_mesh" "fully-connected-mesh" {
  name = "fully-connected-mesh"
}
