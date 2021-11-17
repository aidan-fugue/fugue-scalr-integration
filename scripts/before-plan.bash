#!/bin/bash
#This is the pre-plan hook that checks the validity of the terraform files and
#the security and compliance of the terraform according to CIS Benchmarks
#with Regula (https://regula.dev/).

#Setting variables: length of regula run; terraform validate output; red and green text
regula_exit_code=$(./regula run | wc -l)
tf_validation_code=$(terraform validate)

#Initial run message to tell me that the script it checking my terraform
echo "Checking your terraform for validity and CIS Benchmark compliance with regula."
echo ""

#logic to check for validity and, if not valid, throw an error and non-zero exit code
if [ $regula_exit_code == 3 ] && [ $tf_validation_code == "Success! The configuration is valid." ]; then
  echo "Terraform is valid and compliant."; exit 0
else
  echo "Error! Terraform Apply failed and/or regula run failed."
  echo "Recommend running regula run and terraform validate again and fixing any errors you get."
  echo ""
  echo "See below for the errors we have detected:"
  echo ""
  echo "Security and compliance errors:"
  echo ""
  ./regula run
  echo "Terraform errors:"
  echo ""
  terraform validate
  echo ""; exit 1
fi