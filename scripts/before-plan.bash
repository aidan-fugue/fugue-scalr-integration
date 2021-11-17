#!/bin/bash
#This is the pre-plan hook that checks the validity of the terraform files and
#the security and compliance of the terraform according to CIS Benchmarks
#with Regula (https://regula.dev/).

#Setting variables: length of regula run and terraform validate output
regula_exit_code=$(./regula run | wc -l)
tf_validation_code=$(terraform validate | wc -l)

#Initial run message to tell me that the script it checking my terraform
echo "Checking your terraform for validity and CIS Benchmark compliance with regula..."
echo ""

#logic to check for validity and, if not valid, throw an error and non-zero exit code
if [ $regula_exit_code == 2 ] && [ "$tf_validation_code" == 2 ]; then
  echo "Terraform is valid and compliant."; exit 0
else
  echo "Error! Terraform Apply failed and/or regula run failed."
  echo ""
  echo "Security and compliance errors:"
  echo ""
  ./regula run
  echo "Terraform errors:"
  echo ""
  terraform validate
  echo ""; exit 1
fi