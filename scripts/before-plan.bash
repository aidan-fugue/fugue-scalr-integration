#!/bin/bash
regula_exit_code=$(./regula run | wc -l)
tf_validation_code=$(terraform validate)
echo ""
echo "Checking your terraform for validity and CIS Benchmark compliance with regula."
echo ""
if [ $regula_exit_code == 3 ] && [ $tf_validation_code == "Success! The configuration is valid." ]; then
  echo "Terraform is valid and compliant."; exit 0
else
  echo "Error! Terraform Apply failed and/or regula run failed."
  echo "Recommend running regula run and terraform validate again and fixing any errors you get."
  echo ""
  echo "See below for the errors we have detected:"
  echo ""
  echo "Security and compliance errors:"
  ./regula run
  echo ""
  echo "Terraform errors:"
  terraform validate
  echo ""; exit 1
fi