# Dockerfile for devcontainer to add PHP support
FROM mcr.microsoft.com/devcontainers/javascript-node:20

# Install PHP and common extensions
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        php \
        php-cli \
        php-mbstring \
        php-xml \
        php-curl \
        php-zip \
        php-gd \
        php-mysql \
        php-pgsql \
        php-sqlite3 \
        php-intl \
        php-bcmath \
        php-redis \

# Install Composer
    && apt-get install -y --no-install-recommends curl unzip \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set default shell to bash
SHELL ["/bin/bash", "-c"]
