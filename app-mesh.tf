terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "us-west-2"
}

resource "aws_vpc" "fully-connected-mesh" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    name = "fully-connected-mesh"
  }
}

resource "aws_appmesh_mesh" "fully-connected-mesh" {
  name = "fully-connected-mesh"
}

resource "aws_service_discovery_private_dns_namespace" "fully-connected-mesh" {
  name = "fully-connected-mesh"
  vpc  = aws_vpc.fully-connected-mesh.id
}
