#!/bin/bash
#This is the "Before plan" script that scans for security & compliance violations

#Setting color variables for outputs
green='\033[0;32m'
clear='\033[0m'
red='\033[0;31m'
bold=$(tput bold)
norm=$(tput sgr0)

#Downloading the latest version of Regula
wget -c -nv https://github.com/$(wget -nv \
https://github.com/fugue/regula/releases/latest -O - | \
egrep '/.*/.*/.*_Linux_x86_64.tar.gz' -o)

#Extracting Regula
tar -zxf regula_2.3.0_Linux_x86_64.tar.gz regula

#Scanning for CIS Benchmark security and compliance violations
echo -e "\n${green}${bold}Scanning the security and compliance of your Terraform against CIS Benchmarks with Regula...${clear}${norm} \n"
cd ../
./regula run --include waivers.rego

rc=$?
if [[ $rc != 0 ]]; then
    echo -e "\n${red}${bold}Please fix your security and compliance violations, then re-run the Scalr pipeline.${clear}${norm}\n";
  else 
    echo -e "\n${green}${bold}Security and compliance check passed successfully! Moving on to the next step in the Scalr pipeline.${clear}${norm}\n"
    #(Optional) Send results of security and compliance scan to Fugue UI
    #./regula run --sync --upload
  fi