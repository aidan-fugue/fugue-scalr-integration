#!/bin/bash
echo "Downloading latest version of Regula..."
echo ""

wget -c -nv https://github.com/$(wget -nv https://github.com/fugue/regula/releases/latest -O - | egrep '/.*/.*/.*regula_2.3.0_Linux_x86_64.tar.gz' -o)

#Extracting Regula
tar -zxf regula_2.3.0_Linux_x86_64.tar.gz regula

echo ""
echo "Modifying Regula executable!"
echo ""
chmod u+x regula

echo ""
echo "Run Regula"
echo ""
cd ../
./regula run