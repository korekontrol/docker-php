# hello-world
This example shows basic PHP web application:
 - It uses composer for dependency management
 - Static files are served from `public/` directory. They are included in NginX container
 - All requests are redirected to `index.php` file
 - There are two containers: `hello-world` (which runs php-fpm) and `hello-world-nginx` (which runs NginX)

# Requirements
You need following software installed to run this example:
 - docker
 - docker-compose
 - make

You *don't* need to install PHP, apache, WAMP, LAMP, etc. - it's all handled by `docker`.

# Local development
Please see `docker-compose.yml` for the example.

To start local containers with mounted volume, use the following commands:
```
make build
make up
```

Then open the website at: http://localhost/

All changes to files are immediately available - just refresh the webiste.

Xdebug: `tbd.`

# Production readiness
Please see `docker-compose.prod.yml` for the example.

If you execute `make build`, it builds two containers: one with PHP and another with NginX and static files.
Those two containers are ready for automated CI tests and production run. They don't depend on mapping local files, as code and assets are built in. They also don't require bind-mounting of static files from PHP to NginX containers (which is available with `docker`, but not supported by platforms like AWS ECS or Kubernetes). 

There is a health-check endpoint, which can be used as readiness and liveness probe (for kubernetes) or as a target health check for loadbalancers: `/healthz`. It returns HTTP `200` response, with body: `OK`

Opcache is active by default, and in production example we change its settings so that it offers quckest response times.

NginX container waits for PHP container to become available before it starts (and responds `OK` on health check endpoint). This helps with plaforms like Kubernetes, where we make sure that new release becomes available only after all containers are ready.