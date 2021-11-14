provider "aws" {}

module "s3" {
    source = "/s3"
    bucket_name = "my-scalr-fugue-test-bucket-2731"       
}