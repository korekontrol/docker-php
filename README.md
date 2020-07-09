# PHP base docker image
...with examples and production-ready focus.

It includes PHP application container, ready for production use, based on Debian, as well as documentation about integration with other components.

This `master` branch includes only documentation and examples. For docker container implementation, see branches (each docker release tag corresponds to seperate branch of this repository).


# Versions, branches
| Branch / Version | Docker image |
| ------------- | --- |
| [7.3-buster](tree/7.3-buster) | `korekontrol/php:7.3-buster` |

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

## Credits
Created by [Marek Obuchowicz](https://github.com/marek-obuchowicz) from [KoreKontrol](https://www.korekontrol.eu/)

## License
[MIT](LICENSE)
