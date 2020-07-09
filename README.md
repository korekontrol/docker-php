# PHP

PHP application container, ready for production use, based on Debian.
There is not implementation, only examples `master` branch - each docker release tag corresponds to seperate branch of this repository.

# Versions
| Branch / Version | Docker image |
| ------------- | --- |
| [7.3-buster](tree/7.3-buster) | korekontrol/php:7.3-buster |

# Motivation
There are many examples which explain how to build PHP containers with Docker. There are also official PHP docker repostories. However, during our experience with customer projects at KoreKontrol, we found that most of the examples cover only basic cases - what is needed in real, production hosting is often much more complicated.

Our goals:
 - optimise container sizes. Don't include unneeded crap, like compilers, nodejs, development libraries etc. Small containers are must-have for quick builds and deployments.
 - include opcache, xdebug and composer
 - integrate with modern frameworks
 - support nodejs frontend builds
 - include asset files in seperate nginx container, without volumes for sharing files

## Credits
Created by [Marek Obuchowicz](https://github.com/marek-obuchowicz) from [KoreKontrol](https://www.korekontrol.eu/)

## License
[MIT](LICENSE)
