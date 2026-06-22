FROM php:7.2-apache

# PHP 7.2 image uses Debian buster.
# Buster is archived, so default Debian mirrors may return 404.
RUN set -eux; \
    echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/99archive; \
    echo 'Acquire::AllowInsecureRepositories "true";' >> /etc/apt/apt.conf.d/99archive; \
    echo 'deb http://archive.debian.org/debian buster main contrib non-free' > /etc/apt/sources.list; \
    echo 'deb http://archive.debian.org/debian-security buster/updates main contrib non-free' >> /etc/apt/sources.list; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        libzip-dev \
        zlib1g-dev \
        zip \
        unzip \
        git; \
    docker-php-ext-install mysqli pdo pdo_mysql zip; \
    a2enmod rewrite headers; \
    rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html