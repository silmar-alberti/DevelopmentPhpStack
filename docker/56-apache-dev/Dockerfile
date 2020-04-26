FROM silmaralberti/php:5.6-apache-base

COPY ./settings/entrypoint.sh /usr/local/bin/entrypoint

RUN pecl install xdebug-2.5.5 && \
    docker-php-ext-enable xdebug && \
    chmod +x /usr/local/bin/entrypoint && \
    mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

COPY ./settings/20-xdebug.ini /usr/local/etc/php/conf.d/20-xdebug.ini

ENTRYPOINT ["entrypoint"]
CMD ["apache2-foreground"]