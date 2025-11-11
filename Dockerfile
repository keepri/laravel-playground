FROM php:8.4-fpm

WORKDIR /var/www/html

RUN apt-get update && apt-get install -y \
    git \
    curl \
    zip \
    unzip \
    sqlite3 \
    libsqlite3-dev \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://bun.sh/install | bash
ENV PATH="/root/.bun/bin:${PATH}"

RUN docker-php-ext-install pdo pdo_sqlite bcmath pcntl

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

COPY composer.json composer.lock ./
RUN composer install --no-scripts --no-autoloader --prefer-dist

COPY package.json bun.lock* ./
RUN bun install --frozen-lockfile || bun install

COPY . .

RUN composer dump-autoload --optimize && \
    php artisan config:cache && \
    php artisan route:cache && \
    php artisan view:cache

RUN bun run build

RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

ARG APP_PORT=8000
EXPOSE ${APP_PORT}

CMD php artisan migrate --force && \
    php artisan serve --host=0.0.0.0 --port=${APP_PORT}
