#!/bin/bash

pm2 stop api
pm2 delete api
# pm2 stop cms
# pm2 delete cms
# pm2 stop otc
# pm2 delete otc
# api
cd /var/www/ton-gaming-be-api && pm2 start npm --name "api" -- run start
# cms
# cd /var/www/ton-gaming-cms && pm2 start npm --name "cms" -- run dev
# otc
# cd /var/www/ton-gaming-fe-otc && pm2 start npm --name "otc" -- run dev
