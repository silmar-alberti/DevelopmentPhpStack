FROM silmaralberti/php:7.2-apache-base

COPY  ./entrypoint.sh /usr/local/bin/entrypoint

RUN pecl install xdebug && \
    docker-php-ext-enable xdebug && \
    chmod +x /usr/local/bin/entrypoint && \
    mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

COPY ./20-xdebug.ini /usr/local/etc/php/conf.d/20-xdebug.ini

ENTRYPOINT ["entrypoint"]
CMD ["apache2-foreground"]