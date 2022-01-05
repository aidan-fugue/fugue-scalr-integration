#!/bin/bash
echo "Downloading latest version of Regula..."
echo ""

wget -c https://github.com/$(wget https://github.com/fugue/regula/releases/latest -O - | egrep '/.*/.*/.*regula_2.3.0_Linux_x86_64.tar.gz' -o)

#Extracting Regula
tar -zxf regula_2.3.0_Linux_x86_64.tar.gz regula

#chmod u+x regula

#Running Regula
cd ../
./regula run