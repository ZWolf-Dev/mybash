#! bin/bash

# VARIABLES
FILES_PATH=`ls run/*.sh`
INDEX=0
REPLY=""
declare -a FILES

scan_folder(){

  for EACH_FILE in $FILES_PATH
  do
    FILES+=("$EACH_FILE")
    echo "[$INDEX] ${FILES[$INDEX]}"
    INDEX=$((INDEX+1))
  done
}

echo "List script:"

scan_folder

read -p "Your choose?: " REPLY

echo "---> Choosed Mode: ${FILES[$REPLY]}..."

bash ${FILES[$REPLY]}
