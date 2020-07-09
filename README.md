PHP container, ready for production use, based on Debian images (slim).

We decided to publish and maintain those images, as we see many projects fail into common pitfalls when building PHP images:
 - using official PHP images means slow build process (as PHP extensions are compiled) and lots of unnecessary packages, required by build process of PHP modules
 - using alpine-based images allows more-flexible dependency management and building smaller containers. However, alpine does not offer same libraries and it causes `php-intl` to behave differently - check [this issue](https://github.com/docker-library/php/issues/428) for more information

Supported PHP major versions (corresponds to branches of this repository):

| Branch |
| ------------- |
| `7.3-buster` |

## Configuration
Following environmental variables are available:
| Variable | Default value | Description |
| ------------- |-------------| -----|
| `PHP_MEMORY_LIMIT` | `256m` |
| `PHP_OPCACHE_ENABLE` | `1` |
| `PHP_OPCACHE_MEMORY_CONSUMPTION` | `64` | Value in megabytes
| `PHP_OPCACHE_REVALIDATE_FREQ` | `2` | Ignored if timestamp validation is not enabled
| `PHP_OPCACHE_VALIDATE_TIMESTAMPS` | `0` | Set it to `1` on development environment |
| `PHP_XDEBUG_ENABLE` | `0` | Enable xdebug module; setting it to `1` will disable opcache

