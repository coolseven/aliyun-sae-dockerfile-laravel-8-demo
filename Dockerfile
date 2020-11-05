FROM registry.cn-hangzhou.aliyuncs.com/docker-image-repo-for-develop/php-base:1.0.0

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

COPY ["docker-entrypoint.sh", "/usr/bin/"]

ARG appVersion=v2020-11-05
RUN git clone https://github.com/coolseven/aliyun-sae-laravel-demo --branch $appVersion /app \
  && cd /app \
  && composer install --no-dev --verbose \
  && chmod +rwx /usr/bin/docker-entrypoint.sh \
  && sh -cex /usr/bin/docker-entrypoint.sh
