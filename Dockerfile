FROM registry.cn-hangzhou.aliyuncs.com/docker-image-repo-for-develop/php-base:7.2.27

RUN apk add nginx

COPY s6-service-supervisor/etc/services.d/nginx/run  /etc/services.d/nginx/run
COPY nginx/nginx.conf  /etc/nginx/nginx.conf

COPY s6-service-supervisor/etc/services.d/php-fpm/run  /etc/services.d/php-fpm/run
COPY php-fpm/php-fpm.conf  /use/local/etc/php-fpm.conf

# https://github.com/just-containers/s6-overlay (1.9.1)
COPY s6-overlay-amd64.tar.gz /tmp/s6-overlay-amd64.tar.gz
RUN gunzip -c /tmp/s6-overlay-amd64.tar.gz | tar -xf - -C /

EXPOSE 80

ENTRYPOINT ["/init"]

ARG appTagOrBranch=v20201108-dd6586ae-laravel-7.x
RUN git clone https://github.com/coolseven/aliyun-sae-laravel-demo --branch $appTagOrBranch /app \
  && cd /app \
  && composer install --no-dev --verbose \
  && chown -R www-data:www-data /app \
  && chmod -R 777 /app/storage \
  && chmod +rwx /app/.aliyun-sae/post-deployed.sh
