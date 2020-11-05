#!/usr/bin/env sh

set -eux

php /app/artisan optimize

chown -R www-data:www-data /app

# allow fpm worker (www-data) to create new files under app/storage folder
chmod -R 777 /app/storage