FROM silmaralberti/php:7.2-apache-base

RUN  mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
COPY ./settings/z-opcache-prod.ini /usr/local/etc/php/conf.d/z-opcache.ini
