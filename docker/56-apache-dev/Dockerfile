FROM silmaralberti/php:5.6-apache-base

RUN pecl install xdebug-2.5.5 && \
    docker-php-ext-enable xdebug 

COPY ./20-xdebug.ini /usr/local/etc/php/conf.d/20-xdebug.ini