FROM php:8.4-cli

# PostgreSQL PDO driver
RUN apt-get update \
    && apt-get install -y --no-install-recommends libpq-dev \
    && docker-php-ext-install pdo pdo_pgsql \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . /app

EXPOSE 8000

# Wait-free: compose starts this only after Postgres is healthy.
# Run migrations, then serve the app.
CMD php artisan migrate --force && php artisan serve --host=0.0.0.0 --port=8000
