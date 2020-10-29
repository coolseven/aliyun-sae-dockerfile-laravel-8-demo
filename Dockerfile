FROM registry.cn-hangzhou.aliyuncs.com/docker-image-repo-for-develop/php-base:1.0.0

RUN git clone https://github.com/coolseven/aliyun-sae-laravel-demo /app \
  && cd /app \
  && composer install --no-dev --verbose \
  && php artisan optimize

COPY ["docker-entrypoint.sh", "/usr/bin/"]

EXPOSE 9000

ENTRYPOINT ["sh", "-c", "/usr/bin/docker-entrypoint.sh"]
