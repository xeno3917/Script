FROM php:apache
RUN apt update && apt install postgresql libpq-dev -y
RUN docker-php-ext-install pdo_pgsql && docker-php-ext-enable pdo_pgsql
RUN apt-get update && apt-get upgrade -y
