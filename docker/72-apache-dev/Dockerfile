FROM silmaralberti/php:7.2-apache-base

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