#! bin/bash

DATA=4

get_choose() {
    read -p "Enter num swap (GB): " DATA
}

get_choose

echo "-> Start create swap file $DATA GB..."
echo "-> Disable use swap..."
sudo swapoff -a

echo "-> Allocate swapfile..."
sudo dd if=/dev/zero of=/swapfile bs=1G count="$DATA" status=progress

echo "-> Give root-only permission to it..."
sudo chmod 600 /swapfile

echo "-> Mark the file as SWAP space."
sudo mkswap /swapfile

echo "-> Enable the SWAP"
sudo swapon /swapfile

echo "-> Swap show"
sudo swapon --show

echo "-> Create and enable Swap file $DATA GB success!!"
