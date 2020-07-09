# syntax=docker/dockerfile:1.1.7-experimental
FROM korekontrol/php:7.3-buster

# Add composer dependencies
COPY composer.json composer.lock ./
RUN  composer install --no-interaction --optimize-autoloader --no-scripts

# Add application code
COPY . ./
