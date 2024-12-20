#! bash bin

NORMAL="\\033[0;39m"
BLUE="\\033[1;34m"

read -p "What version php: " -r
PHP="$REPLY"

echo -e "$BLUE => Your choosed is php$REPLY. Start install $NORMAL"
echo -e "$BLUEsudo add-apt-repository ppa:ondrej/php $NORMAL"
sudo add-apt-repository ppa:ondrej/php
echo -e "$BLUEsudo sudo apt update $NORMAL"
sudo apt update
sudo apt install php$REPLY php$REPLY-common php$REPLY-cli php$REPLY-fpm php$REPLY-mysql php$REPLY-zip php$REPLY-gd php$REPLY-mbstring php$REPLY-curl php$REPLY-xml php$REPLY-bcmath php$REPLY-intl php$REPLY-readline php$REPLY-redis php$REPLY-ldap php$REPLY-dom