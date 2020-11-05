#!/usr/bin/env sh

set -eux

# allow fpm worker (www-data) to create new files under app/storage folder
chown -R www-data:www-data /app/storage
chmod -R 777 /app/storage

# allow fpm worker (www-data) to create new files under bootstrap/cache folder
chown -R www-data:www-data /app/bootstrap/cache

php /app/artisan optimize

php-fpm --nodaemonize