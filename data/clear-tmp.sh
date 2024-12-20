#!/bin/bash

# Script name script.sh
# Script for removing all temporary files from temporary directory

TMP_DIR="/tmp"
echo "Removing all temporary files from $TMP_DIR"
  
# Counting the number of temporary files
files=`ls -l $TMP_DIR | wc -l` 

echo "There are total $files temporary files/directory in $TMP_DIR"

rm -rf $TMP_DIR/*

if [[ "$?" == "0" ]];then
    echo "All temporary files successfully deleted"
else
    echo "Failed to delete temporary files"
fi

# Counting the number of temporary files
files=`ls -l $TMP_DIR | wc -l` 

echo "There are total $files temporary files/directory in $TMP_DIR directory"y

