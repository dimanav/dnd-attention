# Stage 1: Build frontend assets (needs both PHP and Node for wayfinder)
FROM php:8.4-cli-alpine AS frontend

# Install Node.js
RUN apk add --no-cache nodejs npm

# Install PHP extensions needed by Laravel
RUN apk add --no-cache \
    libzip-dev \
    oniguruma-dev \
    icu-dev \
    && docker-php-ext-install \
        pdo_mysql \
        mbstring \
        bcmath \
        intl \
        zip

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /app

# Install PHP dependencies first (for php artisan wayfinder:generate)
COPY composer.json composer.lock ./
RUN composer install --no-dev --no-scripts --no-autoloader

# Install Node dependencies
COPY package.json package-lock.json ./
RUN npm ci

# Copy project and build
COPY . .
RUN composer dump-autoload --optimize
RUN npm run build

# Stage 2: PHP application
FROM php:8.4-fpm-alpine AS app

RUN apk add --no-cache \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    libzip-dev \
    oniguruma-dev \
    icu-dev \
    linux-headers \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install \
        pdo_mysql \
        mbstring \
        exif \
        pcntl \
        bcmath \
        gd \
        zip \
        intl \
        opcache

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www

COPY composer.json composer.lock ./
RUN composer install --no-dev --no-scripts --no-autoloader

COPY . .
COPY --from=frontend /app/public/build public/build

RUN composer dump-autoload --optimize \
    && php artisan config:clear \
    && php artisan route:clear \
    && php artisan view:clear

RUN chown -R www-data:www-data storage bootstrap/cache

EXPOSE 9000

CMD ["php-fpm"]
