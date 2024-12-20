#! bash bin

# init read from user
REPLY=""
read -p "What version php ?<82>: " -r
# read PHP in 161
PHP_VER="$REPLY"
PHP_CMD="/usr/local/php$PHP_VER/bin/php"

echo "running app"
echo "[0] re setup server"
echo "[1] clear cache"

read -p "Your choose?: " -r
MODE="$REPLY"

echo "---> Choosed Mode: [$MODE]"

if [[ "$MODE" == '0' ]]; then
    rm -rf vendor composer.lock node_modules
	PHP="usr/local/$PHP_VER/bin/php" bash bin/bootstrap.sh -e d
    yarn
elif [[ "$REPLY" == '1' ]]; then
  	$PHP_CMD artisan optimize
	$PHP_CMD artisan cache:clear
fi

echo "End of action..."
