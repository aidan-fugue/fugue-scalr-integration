#!/bin/bash
#This is the "After plan" script that validates and formats Terraform

#Setting color variables for outputs
green='\033[0;32m'
clear='\033[0m'

echo -e "${green}Validating and fixing the formatting of your Terraform...${clear}"
terraform init && terraform fmt && terraform validate

rc=$?
if [[ $rc != 0 ]]; then
    echo "Please fix the Terraform issues identified above, then re-run the Scalr pipeline.";
  else 
    echo "Terraform checks passed successfully!"
  fi