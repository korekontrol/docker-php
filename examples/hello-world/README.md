# hello-world
This example shows basic PHP web application:
 - it uses composer for dependency management
 - static files are served from `public/` directory
 - all requests are redirected to `index.php` file
 - there are two containers: `hello-world` (which runs `php-fpm`) and `hello-world-nginx` (which runs NginX and includes static files)

# Local development
To start local containers with mounted volume, use the following commands:
```
make build
make up
```

Then open the website at: http://localhost/

# Production containers
If you execute `make build`, it builds two containers: one with PHP and another with NginX and static files.
Those two containers are ready for automated CI tests and production run. They don't depend on mapping local files, as code and assets are built in. They also don't require bind-mounting of static files from PHP to NginX containers (which is available with `docker`, but not supported by platforms like AWS ECS or Kubernetes).
