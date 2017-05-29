FROM php:7.1-fpm-alpine

RUN docker-php-ext-install pdo_mysql bcmath

RUN set -xe \
    && apk upgrade --update \
	&& apk add --no-cache --virtual .build-deps \
        $PHPIZE_DEPS \
        openssl-dev

RUN set -xe \
    && pecl channel-update pecl.php.net \
    && pecl install xdebug mongodb \
    && docker-php-ext-enable xdebug mongodb \
    && apk del .build-deps

RUN echo "xdebug.remote_enable=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_autostart=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_port=9001" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_connect_back=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /var/www/odbav-to