#!/bin/bash
#Following the validation
FILES=$(find . -type f -name "*.tf")
for f in $FILES
do
    echo ""
    echo "Adjust the formatting of $f per HCL canonical standard..."
    #terraform fmt $f
    echo "Done formatting $f!"
    echo ""
done