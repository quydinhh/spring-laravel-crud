# Product CRUD — Spring Boot & Laravel

Two independent REST CRUD services over the **same `products` table shape**, each
backed by PostgreSQL. Built as basic hands-on practice with both stacks.

| Stack | Path | Port | Database | Persistence |
|-------|------|------|----------|-------------|
| Spring Boot 3 (Java 21) | `product-crud/` | 8080 | `crud_demo` | Spring Data JPA |
| Laravel (PHP 8.4) | `product-crud-laravel/` | 8000 | `crud_demo_laravel` | Eloquent ORM |

PostgreSQL 15 runs in Docker and is shared by both (host port **5433**).

## Prerequisites

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) (includes Docker Compose)

No local Java or PHP toolchain needed — everything builds and runs in containers.

## Getting started

```bash
git clone https://github.com/quydinhh/spring-laravel-crud.git
cd spring-laravel-crud
docker compose up -d --build
```

That starts Postgres, builds & runs both apps. First build is slow (Maven +
Composer downloads); later runs are cached.

- Spring:  http://localhost:8080/api/products
- Laravel: http://localhost:8000/api/products

Stop: `docker compose down` (add `-v` to also wipe the DB volume).

## API (identical shape on both)

| Method | Path | Body | Result |
|--------|------|------|--------|
| GET | `/api/products` | — | list |
| GET | `/api/products/{id}` | — | one (404 if missing) |
| POST | `/api/products` | `{ "name": "...", "price": 9.99 }` | 201 created |
| PUT | `/api/products/{id}` | `{ "name": "...", "price": 9.99 }` | updated |
| DELETE | `/api/products/{id}` | — | 204 |

Both validate `name` (required) and `price` (numeric, positive).

## Quick test

```bash
# Spring
curl -X POST localhost:8080/api/products -H "Content-Type: application/json" -d "{\"name\":\"Test\",\"price\":9.99}"
curl localhost:8080/api/products

# Laravel
curl -X POST localhost:8000/api/products -H "Content-Type: application/json" -H "Accept: application/json" -d "{\"name\":\"Test\",\"price\":9.99}"
curl localhost:8000/api/products
```

Or open `requests.http` in VS Code (REST Client) / JetBrains and click through.

## Running a stack locally (without Docker)

Each app also runs standalone if you have the toolchain:
- Spring: `cd product-crud && ./mvnw spring-boot:run` (point `SPRING_DATASOURCE_URL` at your Postgres)
- Laravel: `cd product-crud-laravel && php artisan migrate && php artisan serve` (set `DB_HOST=127.0.0.1` in `.env`)
