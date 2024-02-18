FROM php:8.1-fpm

RUN apt-get update \
        && apt-get install -y libzip-dev \
                libmagickwand-dev --no-install-recommends \
                ghostscript --no-install-recommends \
        && pecl install \
                imagick \
        && docker-php-ext-enable \
                imagick \
        && apt-get purge -y \
                libmagickwand-dev

RUN docker-php-ext-install pdo pdo_mysql mysqli exif zip gd intl
