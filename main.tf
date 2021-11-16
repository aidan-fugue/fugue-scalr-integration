provider "aws" {
    region = "us-east-1"
    shared_credentials_file = "/Users/aidanoconnor/.aws/credentials"
    profile = "aidan_sandbox"
}

module "s3" {
    source = "./s3"
}