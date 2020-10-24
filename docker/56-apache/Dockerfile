FROM php:5.6-apache as baseImage

ENV APACHE_DOCUMENT_ROOT /var/www/html/public 
ENV APPLICATION_ENV 'production'
ENV TZ 'America/Sao_Paulo' 
ENV EXT_REDIS_VERSION=2.2.8 
ENV EXT_IGBINARY_VERSION=2.0.6

COPY ./scripts/bin/* /usr/local/bin/
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

RUN pecl install timezonedb apcu-4.0.11 && \
    docker-php-ext-enable timezonedb apcu && \
    docker-php-ext-configure zip --with-libzip && \
    docker-php-ext-install \
        zip \
        opcache \
        soap \
        mysqli \
        gd \
        pdo_mysql && \
    chmod +x /usr/local/bin/*

COPY ./settings/z-execution.ini /usr/local/etc/php/conf.d/z-execution.ini
COPY ./settings/z-timezone.ini /usr/local/etc/php/conf.d/z-timezone.ini




FROM baseImage as devImage

COPY ./settings/entrypoint.sh /usr/local/bin/entrypoint

ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
COPY ./scripts/bin-dev/* /usr/local/bin/

RUN chmod +x /tini && chmod +x /usr/local/bin/*

RUN pecl install xdebug-2.5.5 && \
    docker-php-ext-enable xdebug && \
    chmod +x /usr/local/bin/entrypoint && \
    mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

COPY ./settings/z-xdebug.ini /usr/local/etc/php/conf.d/z-xdebug.ini
COPY ./settings/z-opcache-dev.ini /usr/local/etc/php/conf.d/z-opcache.ini

ENTRYPOINT ["/tini", "--"]
CMD ["entrypoint", "apache2-foreground"]




FROM baseImage as prodImage

RUN  mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
COPY ./settings/z-opcache-prod.ini /usr/local/etc/php/conf.d/z-opcache.ini