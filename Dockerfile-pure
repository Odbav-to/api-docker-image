FROM php:7.1-fpm-alpine

RUN docker-php-ext-install pdo_mysql bcmath

RUN set -xe \
    && apk upgrade --update \
	&& apk add --no-cache --virtual .build-deps \
        $PHPIZE_DEPS \
        openssl-dev

RUN set -xe \
    && pecl channel-update pecl.php.net \
    && pecl install -o mongodb redis \
    && docker-php-ext-enable mongodb redis \
    && apk del .build-deps \
    && rm -rf /tmp/

WORKDIR /var/www/odbav-to