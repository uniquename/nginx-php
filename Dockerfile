FROM php:8.2-fpm

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libzip-dev \
    zip \
    unzip \
    git \
    curl \
    wget \
    gnupg2 \
    ca-certificates \
    lsb-release \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libxml2-dev \
    libicu-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Configure and install PHP extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) \
    pdo_mysql \
    zip \
    opcache \
    bcmath \
    intl \
    gd \
    exif \
    mysqli \
    pcntl \
    sockets \
    soap \
    xml \
    mbstring

WORKDIR /var/www/html

# Set proper permissions
RUN chown -R www-data:www-data /var/www/html

# Install composer dependencies
COPY composer.json .
COPY composer.lock .
RUN composer install --prefer-dist --no-progress --no-interaction
