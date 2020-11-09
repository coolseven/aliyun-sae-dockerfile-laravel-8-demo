FROM registry.cn-hangzhou.aliyuncs.com/docker-image-repo-for-develop/sae-runtime-for-php:20201109-73116a00

ARG appTagOrBranch=v20201108-d1fa4501-laravel-7.x
RUN git clone https://github.com/coolseven/aliyun-sae-laravel-demo --branch $appTagOrBranch /app \
  && cd /app \
  && composer install --no-dev --verbose \
  && composer clear-cache \
  && chown -R www-data:www-data /app \
  && chmod -R 777 /app/storage \
  && chmod +rwx /app/.aliyun-sae/post-deployed.sh
