FROM php:5.6-apache

ENV APACHE_DOCUMENT_ROOT /var/www/html/public 
ENV APPLICATION_ENV 'production'
ENV TZ 'America/Sao_Paulo' 
ENV EXT_REDIS_VERSION=2.2.8 
ENV EXT_IGBINARY_VERSION=2.0.6

RUN a2enmod rewrite
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y libxml2-dev libpng-dev zlib1g-dev zip libzip-dev && \
    docker-php-source extract \
    # igbinary
    && mkdir -p /usr/src/php/ext/igbinary \
    &&  curl -fsSL https://github.com/igbinary/igbinary/archive/$EXT_IGBINARY_VERSION.tar.gz | tar xvz -C /usr/src/php/ext/igbinary --strip 1 \
    && docker-php-ext-install igbinary \
    # redis
    && mkdir -p /usr/src/php/ext/redis \
    && curl -fsSL https://github.com/phpredis/phpredis/archive/$EXT_REDIS_VERSION.tar.gz | tar xvz -C /usr/src/php/ext/redis --strip 1 \
    && docker-php-ext-configure redis --enable-redis-igbinary \
    && docker-php-ext-install redis \
    # cleanup
    && docker-php-source delete

RUN pecl install timezonedb && \
    docker-php-ext-enable timezonedb && \
    docker-php-ext-configure zip --with-libzip && \
    docker-php-ext-install \
        zip \
        soap \
        mysqli \
        gd \
        pdo_mysql 

COPY ./execution.ini /usr/local/etc/php/conf.d/execution.ini
COPY ./timezone.ini /usr/local/etc/php/conf.d/timezone.ini