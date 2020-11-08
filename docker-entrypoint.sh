#!/usr/bin/env sh

set -eux

chown -R www-data:www-data /app

# allow fpm worker (www-data) to create new files under app/storage folder
chmod -R 777 /app/storage