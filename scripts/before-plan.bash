#!/bin/bash
regula_exit_code=$(./regula run | wc -l)
tf_validation_code=$(terraform validate)
echo ""
echo "Checking your terraform for validity and CIS Benchmark compliance with regula."
echo ""
if [ $regula_exit_code == 3 ] && [ $tf_validation_code == "Success! The configuration is valid." ]; then
  tput setab 2; echo "Terraform is valid and compliant."; exit 0
else
  tput setaf 1; echo "Error! Terraform Apply failed and/or regula run failed."
  echo "Recommend running regula run and terraform validate again and fixing any errors you get."
  echo ""
  echo "See below for the errors we have detected:"
  echo ""
  tput setaf 1; echo "Security and compliance errors:"
  echo ""
  ./regula run
  echo ""
  tput setaf 1; echo "Terraform errors:"
  echo ""
  terraform validate
  echo ""; exit 1
fi