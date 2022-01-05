#!/bin/bash

#Setting color variables for outputs
green='\033[0;32m'
red='\033[0;31m'

echo "Downloading latest version of Regula..."
echo ""

#wget -c -nv https://github.com/$(wget -nv https://github.com/fugue/regula/releases/latest -O - | egrep '/.*/.*/.*regula_2.3.0_Linux_x86_64.tar.gz' -o)
wget -c -nv https://github.com/$(wget -nv https://github.com/fugue/regula/releases/latest -O - | egrep '/.*/.*/.*_Linux_x86_64.tar.gz' -o)

#Extracting Regula
tar -zxf regula_2.3.0_Linux_x86_64.tar.gz regula

echo ""
echo -e "${green}Running Regula on your Terraform...${clear}"
echo ""

cd ../
./regula run