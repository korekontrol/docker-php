PHP container, ready for production use, based on Debian images (slim).

We decided to publish and maintain those images, as we see many projects fail into common pitfalls when building PHP images:
 - using official PHP images means slow build process (as PHP extensions are compiled) and lots of unnecessary packages, required by build process of PHP modules
 - using alpine-based images allows more-flexible dependency management and building smaller containers. However, alpine does not offer same libraries and it causes `php-intl` to behave differently - check [this issue](https://github.com/docker-library/php/issues/428) for more information

Supported PHP major versions (corresponds to branches of this repository):

| Branch |
| ------------- |
| `7.3-buster` |
| `7.4-bullseye` |

For documentation, check `master` branch.
