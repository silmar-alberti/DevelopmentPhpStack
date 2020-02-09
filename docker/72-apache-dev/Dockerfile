FROM silmaralberti/php:7.2-apache-base

RUN pecl install xdebug && \
    docker-php-ext-enable xdebug 

COPY ./20-xdebug.ini /usr/local/etc/php/conf.d/20-xdebug.ini
COPY  ./entrypoint.sh /usr/local/bin/entrypoint

ENTRYPOINT ["entrypoint"]
CMD ["apache2-foreground"]
