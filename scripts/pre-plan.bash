#!/bin/bash
#This script scans Terraform for security & compliance violations;
#and HCL formatting & logic errors. This script should be used as
#the Scalr "Before plan" custom hook.

#Setting color variables for outputs
green='\033[0;32m'
clear='\033[0m'

#Downloading the latest version of Regula
wget -c -nv https://github.com/$(wget -nv \
https://github.com/fugue/regula/releases/latest -O - | \
egrep '/.*/.*/.*_Linux_x86_64.tar.gz' -o)

#Extracting Regula
tar -zxf regula_2.3.0_Linux_x86_64.tar.gz regula

#Scanning for CIS Benchmark security and compliance violations
echo -e "${green}Scanning the security and compliance of your Terraform against CIS Benchmarks with Regula...${clear}"
cd ../
./regula run --include waivers.rego

echo -e "${green}Validating and fixing the formatting of your Terraform...${clear}"
#Adjusting Terraform formatting to match HCL canonical standard
terraform fmt

#Validating Terraform
terraform validate

#(Optional) Send results of security and compliance scan to Fugue UI
#./regula run --sync --upload

echo -e "${green}Security. compliance, validation, and formatting checks are complete!${clear}"