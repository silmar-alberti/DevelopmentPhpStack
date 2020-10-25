FROM php:7.4-apache as baseImage

ENV APACHE_DOCUMENT_ROOT /var/www/html/public 
ENV APPLICATION_ENV 'production'
ENV TZ 'America/Sao_Paulo' 

COPY ./scripts/bin/* /usr/local/bin/

RUN apt-get update -y && \
    apt-get install -y \ 
        zlib1g-dev \
        libzip-dev \
        libxml2-dev \
        libpng-dev \
        && \
    apt-get clean && \
    docker-php-ext-configure zip && \
    docker-php-ext-install \
        zip \
        opcache \
        soap \
        mysqli \
        gd \
        pdo_mysql && \
    pecl install timezonedb igbinary apcu apcu_bc redis && \
    docker-php-ext-enable timezonedb igbinary apcu redis && \
    a2enmod rewrite && \ 
    chmod +x /usr/local/bin/*

COPY ./settings/z-execution.ini /usr/local/etc/php/conf.d/z-execution.ini
COPY ./settings/z-timezone.ini /usr/local/etc/php/conf.d/z-timezone.ini


FROM baseImage as prodImage

RUN  mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
COPY ./settings/z-opcache-prod.ini /usr/local/etc/php/conf.d/z-opcache.ini


FROM baseImage as devImage
ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
COPY ./scripts/bin/* /usr/local/bin/

RUN chmod +x /tini && chmod +x /usr/local/bin/*

COPY ./settings/entrypoint.sh /usr/local/bin/entrypoint

RUN pecl install xdebug && \
    docker-php-ext-enable xdebug && \
    chmod +x /usr/local/bin/entrypoint && \
    mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

COPY ./settings/z-xdebug.ini /usr/local/etc/php/conf.d/z-xdebug.ini
COPY ./settings/z-opcache-dev.ini /usr/local/etc/php/conf.d/z-opcache.ini

ENTRYPOINT ["/tini", "--"]
CMD ["entrypoint", "apache2-foreground"]