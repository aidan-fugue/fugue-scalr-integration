#!/bin/bash

#Setting color variables for outputs
green='\033[0;32m'
clear='\033[0m'

echo "Downloading the latest version of Regula from https://github.com/fugue/regula/releases/latest..."
echo ""
wget -c -nv https://github.com/$(wget -nv https://github.com/fugue/regula/releases/latest -O - | egrep '/.*/.*/.*_Linux_x86_64.tar.gz' -o)

#Extracting Regula
tar -zxf regula_2.3.0_Linux_x86_64.tar.gz regula

echo ""
echo -e "${green}Scanning the security and compliance of your Terraform against CIS Benchmarks with Regula...${clear}"
echo ""
echo -e "${green}Would you like access to more compliance families (such as HIPAA, SOC2, NIST 800-53, CSA, GDPR, ISO 27001, and PCI DSS)?${clear}"
echo -e "${green}Email sales@fugue.co or visit https://www.fugue.co/${clear}"
echo ""
cd ../
./regula run