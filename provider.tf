provider "aws" {
  region = var.region
  profile = var.awsprofile
}

terraform {
  backend "s3" {
    bucket = "giridhar-terraform-statefiles"
    key    = "jenkins/jenkins.tfstate"
    region = "us-east-1"
    profile= "giridhar"
  }
}