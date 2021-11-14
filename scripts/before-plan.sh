#!/bin/bash
# This script is run before terraform plan is run to do the following actions:
# 1. download and run regula on the IaC files in this repo
# 2. run `terraform -fmt check` to ensure terraform is formatted correctly

#https://github.com/fugue/regula/releases/download/v2.0.1/regula_2.0.1_Linux_arm64.tar.gz
regula_exit_code=$(regula run | wc -l)
tf_validation_code=$(terraform validate)
echo ""
tput setaf 4; echo "Checking your terraform for validity and CIS Benchmark compliance with regula."
echo ""
if [$regula_exit_code == 3 ] && [$tf_validation_code == "Success! The configuration is valid." ]; then
  tput setaf 2; echo "Terraform is valid and compliant."; exit 0
else
  tput setaf 1; echo "Error! Terraform Apply failed and/or regula run failed."
  tput setaf 1; echo "Recommend running regula run and terraform validate again and fixing any errors you get."
  echo ""; exit 1
fi