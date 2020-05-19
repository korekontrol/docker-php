# Debian stretch-based container with app user and its home directory - /app

FROM debian:buster-slim

ARG PHP_VERSION
ENV DEBIAN_FRONTEND noninteractive

# Setup application user
RUN groupadd --system --gid 1000 app \
  && useradd --system --gid 1000 --uid 1000 --home-dir /home/app app \
  && install -d -o app -g app /app /home/app

# Install packages
RUN apt-get -qy update \
  && apt-get -qy --no-install-recommends install \
       ca-certificates gnupg \
       bzip2 curl git netbase readline-common vim unzip \
       php${PHP_VERSION} \
       php${PHP_VERSION}-cli \
       php${PHP_VERSION}-fpm \
       php${PHP_VERSION}-bcmath \
       php${PHP_VERSION}-bz2 \
       php${PHP_VERSION}-curl \
       php${PHP_VERSION}-gd \
       php${PHP_VERSION}-gmp \
       php${PHP_VERSION}-intl \
       php${PHP_VERSION}-imap \
       php${PHP_VERSION}-json \
       php${PHP_VERSION}-ldap \
       php${PHP_VERSION}-mbstring \
       php${PHP_VERSION}-mysql \
       php${PHP_VERSION}-opcache \
       php${PHP_VERSION}-pgsql \
       php${PHP_VERSION}-snmp \
       php${PHP_VERSION}-soap \
       php${PHP_VERSION}-sqlite3 \
       php${PHP_VERSION}-xml \
       php${PHP_VERSION}-zip \
       php-igbinary php-imagick php-memcached php-msgpack php-redis php-ssh2 php-xdebug \
  && rm -rf /var/lib/apt/lists/*

RUN curl --silent https://raw.githubusercontent.com/composer/getcomposer.org/76a7060ccb93902cd7576b67264ad91c8a2700e2/web/installer | php -- --quiet --install-dir=/usr/bin --filename=composer

# Configure PHP
COPY php/php-fpm.conf /etc/php/${PHP_VERSION}/fpm/php-fpm.conf
COPY php/pool.conf /etc/php/${PHP_VERSION}/fpm/pool.conf
COPY php/conf.d/ /etc/php/${PHP_VERSION}/mods-available/
RUN chown -R app:app /etc/php/${PHP_VERSION}/fpm/conf.d /etc/php/${PHP_VERSION}/cli/conf.d /var/lib/php/modules/${PHP_VERSION}/fpm/ /var/lib/php/modules/${PHP_VERSION}/cli/
RUN ln -s /usr/sbin/php-fpm${PHP_VERSION} /usr/sbin/php-fpm

# Container start
COPY php/entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD "php-fpm7.3"

# Home directory for container service
USER app
WORKDIR /home/app

# Install prestissimo for improved composer performance
RUN cd /home/app && composer require -o --no-scripts hirak/prestissimo

# Application environment defaults
WORKDIR /app
EXPOSE 9000
ENV PHP_MEMORY_LIMIT=256m
# ENV PHP_FPM_PROCESSES=2
# ENV PHP_FPM_MAX_PROCESSES=4
ENV PHP_OPCACHE_ENABLE=1
ENV PHP_OPCACHE_MEMORY_CONSUMPTION=64
ENV PHP_OPCACHE_REVALIDATE_FREQ=2
ENV PHP_OPCACHE_VALIDATE_TIMESTAMPS=0
ENV PHP_XDEBUG_ENABLE=0
