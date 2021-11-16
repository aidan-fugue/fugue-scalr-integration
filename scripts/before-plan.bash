#!/bin/bash
mkdir regula
cd regula
curl -L "https://github.com/fugue/regula/releases/download/v2.0.1/regula_2.0.1_Linux_x86_64.tar.gz" | tar -xvz -C "$HOME/regula"
mv /home/ubuntu/regula/regula /usr/local/bin
regula_exit_code=$(regula run | wc -l)
tf_validation_code=$(terraform validate)
echo ""
echo "Checking your terraform for validity and CIS Benchmark compliance with regula."
echo ""
if [ $regula_exit_code == 3 ] && [ $tf_validation_code == "Success! The configuration is valid." ]; then
  echo "Terraform is valid and compliant."; exit 0
else
  echo "Error! Terraform Apply failed and/or regula run failed."
  echo "Recommend running regula run and terraform validate again and fixing any errors you get."
  echo ""; exit 1
fi