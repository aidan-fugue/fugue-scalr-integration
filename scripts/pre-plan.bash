#!/bin/bash
echo "Downloading latest version of Regula..."
wget https://github.com/$(wget https://github.com/fugue/regula/releases/latest -O - | egrep '/.*/.*/.*regula_2.3.0_Linux_x86_64.tar.gz' -o)
tar -xf regula_2.3.0_Linux_x86_64.tar.gz
mv regula_2.3.0_Linux_x86_64 /usr/local/bin/regula
chmod 755 /usr/local/bin/regula

echo "Current Regula version:"
regula version

echo "Run Regula"
regula run