FROM php:8-cli

# ワークディレクトリの設定
WORKDIR /var/www/html


RUN apt-get update \
    && apt-get install -y libonig-dev libzip-dev unzip \
    && docker-php-ext-install mbstring zip bcmath \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug

# プロジェクトファイルをコピー
COPY ./src /var/www/html
COPY ./docker/app/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

ENTRYPOINT ["tail", "-f", "/dev/null"]
