#!/bin/bash
brew tap fugue/regula
brew install regula
regula_exit_code=$(regula run | wc -l)
tf_validation_code=$(terraform validate)
echo ""
tput setaf 4; echo "Checking your terraform for validity and CIS Benchmark compliance with regula."
echo ""
if [$regula_exit_code == 3 ] && [$tf_validation_code == "Success! The configuration is valid." ]; then
  tput setaf 2; echo "Terraform is valid and compliant.";
else
  tput setaf 1; echo "Error! Terraform Apply failed and/or regula run failed."
  tput setaf 1; echo "Recommend running regula run and terraform validate again and fixing any errors you get."
  echo "";
fi