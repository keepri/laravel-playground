FROM php:8.5-fpm

WORKDIR /var/www/html

RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
    && apt-get update && apt-get install -y \
    git \
    curl \
    zip \
    unzip \
    sqlite3 \
    libmagickwand-dev \
    libsqlite3-dev \
    libzip-dev \
    libicu-dev \
    libpq-dev \
    nginx \
    nodejs \
    && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install pdo pdo_sqlite pdo_pgsql pgsql bcmath pcntl intl zip \
    && pecl install imagick \
    && docker-php-ext-enable imagick intl zip pdo_pgsql pgsql \
    && rm -rf /var/lib/apt/lists/*

ARG NODE_ENV=production

# install dependencies
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

COPY composer.json composer.lock ./
RUN composer install --no-scripts --no-autoloader --prefer-dist

COPY package.json package-lock.json ./
RUN npm ci

# NGINX
COPY docker/nginx.conf /etc/nginx/sites-available/default

# Copy production PHP-FPM configuration
RUN rm -f /usr/local/etc/php-fpm.conf
COPY docker/php-fpm.conf /usr/local/etc/
COPY docker/php-fpm.d /usr/local/etc/php-fpm.d

COPY . .

RUN composer dump-autoload --optimize
RUN npm run build && \
    rm -f public/hot && \
    php artisan package:discover --ansi && \
    php artisan filament:assets && \
    php artisan livewire:publish --assets

RUN chown -R www-data:www-data \
    /var/www/html/storage \
    /var/www/html/bootstrap/cache \
    /var/www/html/database/storage

EXPOSE 8000

CMD php artisan config:cache && \
    php artisan route:cache && \
    php artisan view:cache && \
    php artisan event:cache && \
    php artisan optimize && \
    php artisan migrate --force && \
    php-fpm -D && \
    exec nginx -g "daemon off;"

