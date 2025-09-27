# ---- Build stage: install Laravel with Composer ----
FROM php:8.2-cli AS builder
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies for building mbstring
RUN apt-get update \
 && apt-get install -y --no-install-recommends unzip libonig-dev pkg-config \
 && docker-php-ext-configure mbstring \
 && docker-php-ext-install -j"$(nproc)" mbstring \
 && rm -rf /var/lib/apt/lists/*

# Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Create Laravel project (no dev deps to keep it light)
WORKDIR /app
ARG LARAVEL_VERSION="^11.0"
RUN composer create-project --no-dev --prefer-dist laravel/laravel:"${LARAVEL_VERSION}" .

# Copy local overrides (if any)
COPY . .

# Optimize autoload and generate app key
ENV APP_ENV=production
RUN php artisan key:generate --ansi \
 && php artisan config:clear \
 && php artisan route:clear \
 && php artisan view:clear

# ---- Runtime stage: slim PHP container serving /public on :8080 ----
FROM php:8.2-cli
ENV DEBIAN_FRONTEND=noninteractive

# Install only runtime deps needed for Laravel
RUN apt-get update \
 && apt-get install -y --no-install-recommends unzip libonig-dev pkg-config \
 && docker-php-ext-configure mbstring \
 && docker-php-ext-install -j"$(nproc)" mbstring \
 && apt-get purge -y --auto-remove libonig-dev pkg-config \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY --from=builder /app /app

# Healthcheck (simple: ping the root)
HEALTHCHECK --interval=30s --timeout=3s CMD php -r "try{ echo file_get_contents('http://127.0.0.1:8080')?0:1; }catch(Exception $e){ exit(1);}";

# Laravel served by PHP's built-in server (fine for workshop demos)
EXPOSE 8080
CMD ["php", "-S", "0.0.0.0:8080", "-t", "public", "public/index.php"]
