#!/bin/bash

# Author: NakamuraOS
# https://github.com/nakamuraos
# Latest update: 30/03/2022
# Tested on Navicat 15.x, 16.x on Linux

RED="\e[1;31m"
ENDCOLOR="\e[0m"

echo -e "${RED}"
echo -e "======================================="
echo -e "|           !!! OPEN VPN !!!          |"
echo -e "======================================="
echo -e "|            Visual Weber             |"
echo -e "|                                     |"
echo -e "======================================="
echo -e "${ENDCOLOR}"

sudo openvpn --config $HOME/VisualWeber_IP150.ovpn --auth-user-pass $HOME/openvpn_login.conf --daemon

echo "Open vpn is running..."
