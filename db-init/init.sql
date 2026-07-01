-- Postgres runs every *.sql here once, on first init of the data volume.
-- POSTGRES_DB (see docker-compose.yml) already creates "crud_demo".
-- Spring Boot uses crud_demo; Laravel uses crud_demo_laravel.
CREATE DATABASE crud_demo_laravel;
