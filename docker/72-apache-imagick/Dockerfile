FROM php:7.2-apache

ENV APACHE_DOCUMENT_ROOT /var/www/html/public 
ENV TZ 'America/Sao_Paulo' 

RUN apt-get update -y && \
    apt-get install -y \ 
        zlib1g-dev \
        libzip-dev \
        libxml2-dev \
        libpng-dev \
        # imap
        libc-client-dev \
        libkrb5-dev \
        # imagick
        libmagickwand-dev \
        --no-install-recommends  && \
    apt-get clean && \
    docker-php-ext-configure zip --with-libzip && \
    docker-php-ext-configure imap --with-kerberos --with-imap-ssl && \
    docker-php-ext-install \
        zip \
        soap \
        bcmath \
        mysqli \
        gd \
        pdo_mysql \
        imap \
        && \
    pecl install timezonedb igbinary redis apcu apcu_bc imagick && \
    docker-php-ext-enable timezonedb igbinary redis apcu imagick && \
    a2enmod rewrite

COPY ./settings/execution.ini /usr/local/etc/php/conf.d/execution.ini
COPY ./settings/timezone.ini /usr/local/etc/php/conf.d/timezone.ini
