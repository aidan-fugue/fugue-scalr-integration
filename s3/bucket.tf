resource "aws_s3_bucket" "demos3" {
    bucket      = "my-scalr-fugue-test-bucket-2731"
    acl         = "${var.acl_value}"
}