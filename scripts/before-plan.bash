#!/bin/bash
#This is the pre-plan hook that checks the validity of the terraform files and
#the security and compliance of the terraform according to CIS Benchmarks
#with Regula (https://regula.dev/).

#Setting variables: length of regula run and terraform validate output
regula_exit_code=$(./regula run --include waivers.rego | wc -l)
tf_validation_code=$(terraform validate | wc -l)

#Setting color variables for outputs
green='\033[0;32m'
clear='\033[0m'
red='\033[0;31m'

#Initial run message to tell me that the script it checking my terraform
echo "Checking your terraform for validity and CIS Benchmark compliance with regula..."
echo ""

#logic to check for validity and, if not valid, throw an error and non-zero exit code
if [ $regula_exit_code == 2 ] && [ "$tf_validation_code" == 2 ]; then
  echo -e "${green}Terraform is valid and compliant.${clear}"; exit 0
else
  echo -e "${red}Error! Terraform Apply failed and/or regula run failed.${clear}"
  echo ""
  echo -e "${red}Security and compliance errors:${clear}"
  echo ""
  ./regula run --include waivers.rego
  echo -e "${red}Terraform errors:${clear}"
  echo ""
  terraform validate
  echo ""; exit 1
fi