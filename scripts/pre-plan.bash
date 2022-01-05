#!/bin/bash
echo "Downloading latest version of Regula..."
sudo wget https://github.com/$(wget https://github.com/fugue/regula/releases/latest -O - | egrep '/.*/.*/.*regula_2.3.0_Linux_x86_64.tar.gz' -o) -P /usr/local/bin/
mv /usr/local/bin/regula_2.3.0_Linux_x86_64 /usr/local/bin/regula
chmod 755 /usr/local/bin/regula

echo "Current Regula version:"
regula version

echo "Run Regula"
regula run