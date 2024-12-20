#! bash bin

NORMAL="\\033[0;39m"
VERT="\\033[1;32m"
ROUGE="\\033[1;31m"
BLUE="\\033[1;34m"
ORANGE="\\033[1;33m"

read -p "What version php-fpm <8.1>" -r
PHP="$REPLY"
read -p "Enter folder in /var/www/<folder>:" -r
sudo chmod -R 777 /etc/hosts
# CREATE PROJECT FOLDER
echo -e "$BLUE Create project folder... $NORMAL"
sudo mkdir -p "/var/www/$REPLY"
sudo chmod -R 777 "/var/www/$REPLY"
sudo mkdir -p "/var/www/$REPLY/public"
sudo chmod -R 777 "/var/www/$REPLY/public"

# CREATE FILE INDEX PHP
sudo touch "/var/www/$REPLY/public/index.php"
sudo chmod -R 777 "/var/www/$REPLY/public/index.php"
echo    "<html><body><h1>Project $REPLY created!</h1></body></html>"               >> "/var/www/$REPLY/public/index.php"
sudo rm -rf "/var/www/$REPLY/public/index.php"

# RECREATE FILE INDEX PHP
sudo touch "/var/www/$REPLY/public/index.php"
sudo chmod -R 777 "/var/www/$REPLY/public/index.php"
echo    "<html><body><h1>Project $REPLY created!</h1></body></html>"               >> "/var/www/$REPLY/public/index.php"

echo -e "$BLUE Create project folder success! $NORMAL"
echo -e "$BLUE New project path : /var/www/$REPLY $NORMAL"


# CREATE FILE SITE NGINX
sudo chmod -R 777 "/etc/nginx/sites-available"
sudo chmod -R 777 "/etc/nginx/sites-enabled"
echo -e "$BLUE Create file site nginx $REPLY $NORMAL"
touch "/etc/nginx/sites-available/$REPLY"
rm -rf "/etc/nginx/sites-available/$REPLY"
rm -rf "/etc/nginx/sites-enabled/$REPLY"
touch "/etc/nginx/sites-available/$REPLY"
sudo chmod -R 777 "/etc/nginx/sites-available/$REPLY"

echo -e "$BLUE Start write to to $REPLY $NORMAL"

echo    "server {"                                                                      >> "/etc/nginx/sites-available/$REPLY"
echo    "   listen 443 ssl http2;"                                                      >> "/etc/nginx/sites-available/$REPLY"
echo    "   listen [::]:443 ssl http2;"                                                 >> "/etc/nginx/sites-available/$REPLY"
echo    "   server_name $REPLY;"                                                        >> "/etc/nginx/sites-available/$REPLY"
echo    "   root /var/www/$REPLY/public;"                                               >> "/etc/nginx/sites-available/$REPLY"
echo    '   add_header X-Frame-Options "SAMEORIGIN";'                                   >> "/etc/nginx/sites-available/$REPLY"
echo   	'   add_header X-XSS-Protection "1; mode=block";'                               >> "/etc/nginx/sites-available/$REPLY"
echo   	'   add_header X-Content-Type-Options "nosniff";'                               >> "/etc/nginx/sites-available/$REPLY"
echo   	'   ssl_certificate     /etc/ssl/certs/ssl-cert-snakeoil.pem;'                  >> "/etc/nginx/sites-available/$REPLY"
echo   	'   ssl_certificate_key /etc/ssl/private/ssl-cert-snakeoil.key;'                >> "/etc/nginx/sites-available/$REPLY"
echo   	'   index index.html index.htm index.php;'                                      >> "/etc/nginx/sites-available/$REPLY"
echo   	'   charset utf-8;'                                                             >> "/etc/nginx/sites-available/$REPLY"
echo   	'   location / {'                                                               >> "/etc/nginx/sites-available/$REPLY"
echo   	'       try_files $uri $uri/ /index.php?$query_string;'                         >> "/etc/nginx/sites-available/$REPLY"
echo   	'   }'                                                                          >> "/etc/nginx/sites-available/$REPLY"
echo   	'   location = /favicon.ico { access_log off; log_not_found off; }'             >> "/etc/nginx/sites-available/$REPLY"
echo   	'   location = /robots.txt  { access_log off; log_not_found off; }'             >> "/etc/nginx/sites-available/$REPLY"
echo   	'   error_page 404 /index.php;'                                                 >> "/etc/nginx/sites-available/$REPLY"
echo   	'   location ~ \.php$ {'                                                        >> "/etc/nginx/sites-available/$REPLY"
echo   	'       fastcgi_pass unix:/var/run/php/php'$PHP'-fpm.sock;'                     >> "/etc/nginx/sites-available/$REPLY"
echo   	'       fastcgi_index index.php;'                                               >> "/etc/nginx/sites-available/$REPLY"
echo   	'       fastcgi_param SCRIPT_FILENAME $realpath_root$fastcgi_script_name;'      >> "/etc/nginx/sites-available/$REPLY"
echo   	'       include fastcgi_params;'                                                >> "/etc/nginx/sites-available/$REPLY"
echo   	'   }'                                                                          >> "/etc/nginx/sites-available/$REPLY"
echo   	'   location ~ /\.(?!well-known).* {'                                           >> "/etc/nginx/sites-available/$REPLY"
echo   	'       deny all;'                                                              >> "/etc/nginx/sites-available/$REPLY"
echo   	'   }'                                                                          >> "/etc/nginx/sites-available/$REPLY"
echo   	'}'                                                                             >> "/etc/nginx/sites-available/$REPLY"
echo -e "$BLUE File $REPLY created success! $NORMAL"
echo -e "$BLUE File path: /etc/nginx/sites-available/$REPLY $NORMAL"

sudo chmod -R 777 /etc/hosts
if grep -xqFe "127.0.0.1       $REPLY" "/etc/hosts"; then
    echo -e "$ORANGE Exitst this host name... $NORMAL"
else
    echo -e "$BLUE 127.0.0.1       $REPLY to hosts! $NORMAL"
    echo "127.0.0.1       $REPLY" >> "/etc/hosts"
fi

echo -e "$BLUE Linking file site to sites-enabled $NORMAL"
echo -e "$BLUE sudo ln -s /etc/nginx/sites-available/$REPLY /etc/nginx/sites-enabled/ $NORMAL"
sudo ln -s "/etc/nginx/sites-available/$REPLY" /etc/nginx/sites-enabled/

echo -e "$BLUE sudo service nginx restart $NORMAL"
sudo service nginx restart

echo -e "$BLUE if nginx restart fail please install ssl, remove or disable apache2! $NORMAL"
echo -e "$ORANGE sudo apt install ssl-cert $NORMAL"
echo -e "$ORANGE sudo make-ssl-cert generate-default-snakeoil --force-overwrite $NORMAL"
echo -e "$ORANGE sudo service apache2 stop $NORMAL"

echo -e "$ORANGE site available in: https://$REPLY $NORMAL"
echo -e "$ORANGE folder project: cd /var/www/$REPLY$NORMAL"
