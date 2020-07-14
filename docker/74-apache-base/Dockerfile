FROM php:7.4-apache

ENV APACHE_DOCUMENT_ROOT /var/www/html/public 
ENV APPLICATION_ENV 'production'
ENV TZ 'America/Sao_Paulo' 

RUN apt-get update -y && \
    apt-get install -y \ 
        zlib1g-dev \
        libzip-dev \
        libxml2-dev \
        libpng-dev \
        && \
    apt-get clean && \
    docker-php-ext-configure zip --with-libzip && \
    docker-php-ext-install \
        zip \
        soap \
        mysqli \
        gd \
        pdo_mysql && \
    pecl install timezonedb igbinary redis apcu apcu_bc && \
    docker-php-ext-enable timezonedb igbinary redis apcu && \
    a2enmod rewrite

COPY ./settings/execution.ini /usr/local/etc/php/conf.d/execution.ini
COPY ./settings/timezone.ini /usr/local/etc/php/conf.d/timezone.ini