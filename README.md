# PHP base docker image
...with integration examples, development support and production-ready focus.

It includes PHP application container (ready for production use, with development tools available) - based on Debian, as well as documentation and examples for integration with other components.

This `master` branch includes only documentation and examples. For docker container implementation, see branches (each docker release tag corresponds to seperate branch of this repository).

# Versions, branches
| Branch / Version | Docker image |
| ------------- | --- |
| [7.4-bullseye](https://github.com/korekontrol/docker-php/tree/7.4-bullseye) | `korekontrol/php:7.4-bullseye` |
| [7.3-buster](https://github.com/korekontrol/docker-php/tree/7.3-buster) | `korekontrol/php:7.3-buster` |

Images are published daily to [docker hub repository](https://hub.docker.com/repository/docker/korekontrol/php)


# Motivation
There are many examples which explain how to build PHP containers with Docker. There are also official PHP docker repostories. However, during our experience with customer projects at KoreKontrol, we found that most of the examples cover only basic cases - what is needed in real, production hosting is often much more complicated.

Our goals:
 - Optimise container sizes. Don't include unneeded crap, like compilers, nodejs, development libraries etc. Small containers are must-have for quick builds and deployments.
 - Provide daily images, with latest patches and minor versions.
 - Include opcache, xdebug and composer.
 - Integrate with modern frameworks.
 - Support node.js frontend builds.
 - Include asset files in seperate NginX container, without volumes for sharing files.

# Reference
## Configuration

Following environmental variables are available:
| Variable | Default value | Comments |
| ------------- |-------------| -----|
| `PHP_MEMORY_LIMIT` | `256m` |
| `PHP_OPCACHE_ENABLE` | `1` |
| `PHP_OPCACHE_MEMORY_CONSUMPTION` | `64` | Value in megabytes
| `PHP_OPCACHE_REVALIDATE_FREQ` | `2` | Ignored if timestamp validation is not enabled
| `PHP_OPCACHE_VALIDATE_TIMESTAMPS` | `0` | Set it to `1` on development environment
| `PHP_XDEBUG_ENABLE` | `0` | Enable xdebug module; setting it to `1` will disable opcache. Don't use on production.



## Credits
Created by [Marek Obuchowicz](https://github.com/marek-obuchowicz) from [KoreKontrol](https://www.korekontrol.eu/)

## License
[MIT](LICENSE)
