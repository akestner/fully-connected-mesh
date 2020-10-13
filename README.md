# Fully Connected Mesh 

This is a [Terraform-based](https://www.terraform.io/) project to configure a "fully-connected" App Mesh mesh.. By fully-connected, we mean that this is a mesh where there is far more service-to-servce (or east-west) traffic than ingress or egress (or north-south) traffic.

## Mesh Structure

This is a diagram of the structure of the mesh this project creates

## Getting Started

To get started using this project, you need to have [Terraform installed](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started) and AWS credentials configured on your machine. 

You can then run the following commands (all from the root of this repository):

1. Initialize Terraform

    ```shell script
    $ terraform init 
    ```

2. _(Optional)_ Validate the terraform configuration

    ```shell script
    $ terraform validate
    ```
   
3. _(Optional)_ See what changes Terraform will make to your AWS resources

    ```shell script
    $ terraform plan
    ```
   
4. Apply the changes in the Terraform configuration
    ```shell script
    $ terraform apply
    ```
