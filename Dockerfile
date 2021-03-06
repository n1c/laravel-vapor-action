FROM laradock/workspace:latest-7.4

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /composer
ENV PATH "/composer/vendor/bin:~/.local/bin:$PATH"

RUN set -xe && \
    curl --silent --location https://deb.nodesource.com/setup_15.x | bash - && \
    apt-get update && \
    apt-get install -y --force-yes nodejs \
    php7.4-imagick \
    openssh-client \
    unzip

RUN set -xe && \
    composer global require laravel/vapor-cli && \
    composer clear-cache

# Prepare out Entrypoint (used to run Vapor commands)
COPY vapor-entrypoint /usr/local/bin/vapor-entrypoint

ENTRYPOINT ["/usr/local/bin/vapor-entrypoint"]
