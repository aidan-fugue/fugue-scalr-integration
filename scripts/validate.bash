#!/bin/bash
#This is the "After plan" script that validates and formats Terraform

#Setting color variables for outputs
green='\033[0;32m'
clear='\033[0m'
red='\033[0;31m'
bold=$(tput bold)
norm=$(tput sgr0)

echo -e "\n${green}${bold}Validating and fixing the formatting of your Terraform...${clear}${norm}\n"
terraform init && terraform fmt && terraform validate

rc=$?
if [[ $rc != 0 ]]; then
    echo -e "\n${red}${bold}Please fix the Terraform issues identified above, then re-run the Scalr pipeline.${clear}${norm}\n";
  else 
    echo -e "${green}${bold}\nTerraform checks passed successfully!${clear}${norm}\n"
  fi