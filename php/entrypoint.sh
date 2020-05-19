#!/bin/bash

if [[ $PHP_XDEBUG_ENABLE == 1 ]]; then
  echo "WARNING: xdebug support enabled, opcache will be disabled. This will affect performance and shound not be done on production"
  phpdismod opcache
else
  phpdismod xdebug
fi

if [[ $PHP_OPCACHE_ENABLE != 1 ]]; then
  echo "disabling opcache"
  phpdismod opcache
fi

exec "$@"