FROM registry.cn-hangzhou.aliyuncs.com/docker-image-repo-for-develop/php-base:1.0.0

RUN git clone https://github.com/coolseven/aliyun-sae-laravel-demo /app \
  && cd /app \
  && composer install --no-dev --verbose

COPY ["docker-entrypoint.sh", "/usr/bin/"]

RUN chmod +rwx /usr/bin/docker-entrypoint.sh

EXPOSE 9000

ENTRYPOINT ["sh", "-cex", "/usr/bin/docker-entrypoint.sh"]
