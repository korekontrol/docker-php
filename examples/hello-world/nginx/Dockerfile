# syntax=docker/dockerfile:1.1.7-experimental
FROM nginx:1.18

# Add dependencies
RUN apt-get -qy update && \
    apt-get -qy install --no-install-recommends wait-for-it && \
    rm -rf /var/lib/apt/lists/*

# Add configuration
COPY nginx/conf.d/ /etc/nginx/conf.d/
CMD /bin/bash -c "envsubst '\$SERVER_NAME \$PHP_HOST' < /etc/nginx/conf.d/default.template > /etc/nginx/conf.d/default.conf && wait-for-it -t ${PHP_WAIT_TIMEOUT:-300} ${PHP_HOST}:9000 && echo 'Starting NginX' && nginx -g 'daemon off;'"

# Add static content
RUN mkdir /app
COPY public/ /app/public/
