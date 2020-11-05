FROM registry.cn-hangzhou.aliyuncs.com/docker-image-repo-for-develop/php-base:1.0.0

ARG appVersion=v2020-11-05
RUN git clone https://github.com/coolseven/aliyun-sae-laravel-demo --branch $appVersion /app \

  && cd /app \
  && composer install --no-dev --verbose \
  && php artisan optimize

COPY ["docker-entrypoint.sh", "/usr/bin/"]

EXPOSE 9000

ENTRYPOINT ["sh", "-c", "/usr/bin/docker-entrypoint.sh"]
