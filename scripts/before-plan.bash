#!/bin/bash
#This is the pre-plan hook that checks the validity of the terraform files and
#the security and compliance of the terraform according to CIS Benchmarks
#with Regula (https://regula.dev/).

#Setting variables: length of regula run and terraform validate output
a=$(./regula run --exclude FG_R00275)
arr=($a)
tf_validation_code=$(terraform validate)

#Initial run message to tell me that the script it checking my terraform
echo "Checking your terraform for validity and CIS Benchmark compliance with regula..."
echo ""

#logic to check for validity and, if not valid, throw an error and non-zero exit code
if [ "${arr[@]:0:3}" == "No problems found." ] && [ $tf_validation_code == "Success! The configuration is valid." ]; then
  echo "Terraform is valid and compliant."; exit 0
else
  echo "Error! Terraform Apply failed and/or regula run failed."
  echo ""
  echo "Security and compliance errors:"
  echo ""
  ./regula run --exclude FG_R00275
  echo "Terraform errors:"
  echo ""
  terraform validate
  echo ""; exit 1
fi