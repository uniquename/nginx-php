FROM php:8.4-fpm

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends libzip-dev zip unzip git curl wget gnupg2 ca-certificates lsb-release && \
    rm -rf /var/lib/apt/lists/*
# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
# Install PHP extensions
RUN docker-php-ext-install pdo_mysql zip opcache bcmath intl gd exif mysqli pcntl sockets soap xmlrpc xsl mbstring

USER root

C
