FROM php:apache
RUN apt update && apt upgrade -y
RUN apt install libpq-dev postgresql libonig-dev zlib1g-dev libpng-dev -y
RUN docker-php-ext-install pdo_pgsql && docker-php-ext-enable pdo_pgsql
RUN docker-php-ext-install mbstring && docker-php-ext-enable mbstring
RUN docker-php-ext-install gd && docker-php-ext-enable gd
