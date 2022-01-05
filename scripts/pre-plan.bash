#!/bin/bash
echo "Downloading latest version of Regula..."
echo ""

wget -c https://github.com/$(wget https://github.com/fugue/regula/releases/latest -O - | egrep '/.*/.*/.*regula_2.3.0_Linux_x86_64.tar.gz' -o)

echo ""
echo "Extracting Regula"
echo ""
tar -zxvf regula_2.3.0_Linux_x86_64.tar.gz -O > regula

echo ""
echo "Modifying Regula executable!"
echo ""
chmod u+x regula

echo ""
echo "Working directory:"
echo ""
pwd

echo "Contents of working directory"
ls regula

echo ""
echo "Run Regula"
echo ""
./regula run *.tf
./regula run ../*/tf