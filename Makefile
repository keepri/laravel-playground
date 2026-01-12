.PHONY: help

help:
	@echo "Available commands:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

# Development
dev: ## Start all dev services (Docker + Vite + Logs)
	@echo "Starting development environment..."
	@docker compose up -d
	@bunx concurrently -c "auto" \
		-n "vite,app,queue,laravel" \
		--kill-others \
		"bun run dev" \
		"docker compose logs -f app" \
		"docker compose logs -f queue" \
		"docker compose exec app php artisan pail"

dev-stop: ## Stop dev environment
	@docker compose down
	@pkill -f "vite" || true

install: ## Install all dependencies
	composer install
	bun install
	@echo "Dependencies installed!"

# Docker
up: ## Start containers
	docker compose up -d

down: ## Stop containers
	docker compose down

build: ## Build containers
	docker compose down -v
	docker compose build

rebuild: ## Rebuild and start containers
	docker compose down -v
	docker compose up -d --build

restart: ## Restart containers
	docker compose restart

logs: ## Show logs
	@bunx concurrently -c "auto" \
		-n "app,queue,laravel" \
		--kill-others \
		"docker compose logs -f app" \
		"docker compose logs -f queue" \
		"docker compose exec app php artisan pail"

logs-app: ## Show app logs
	docker compose logs -f --tail=100 app

logs-queue: ## Show queue logs
	docker compose logs -f --tail=100 queue

logs-laravel: ## Show laravel logs
	docker compose exec app php artisan pail

log-clear: ## Clear Laravel logs
	docker compose exec app sh -c 'truncate -s 0 storage/logs/*.log'

ps: ## List containers
	docker compose ps

shell: ## Shell into app container
	docker compose exec app sh

# Laravel
artisan: ## Run artisan command (usage: make artisan cmd="migrate")
	docker compose exec app php artisan $(cmd)

migrate: ## Run migrations
	docker compose exec app php artisan migrate

migrate-fresh: ## Fresh migrations
	docker compose exec app php artisan migrate:fresh

migrate-rollback: ## Rollback migrations
	docker compose exec app php artisan migrate:rollback

migrate-seed: ## Migrate and seed
	docker compose exec app php artisan migrate --seed

seed: ## Run seeders
	docker compose exec app php artisan db:seed

tinker: ## Open tinker
	docker compose exec app php artisan tinker

cache-clear: ## Clear all cache
	docker compose exec app php artisan cache:clear
	docker compose exec app php artisan config:clear
	docker compose exec app php artisan route:clear
	docker compose exec app php artisan view:clear

optimize: ## Optimize application
	docker compose exec app php artisan optimize

# Queue
queue-work: ## Run queue worker
	docker compose exec app php artisan queue:work

queue-listen: ## Listen to queue
	docker compose exec app php artisan queue:listen

queue-restart: ## Restart queue workers
	docker compose exec app php artisan queue:restart

queue-failed: ## List failed jobs
	docker compose exec app php artisan queue:failed

queue-retry: ## Retry failed job (usage: make queue-retry id=1)
	docker compose exec app php artisan queue:retry $(id)

queue-retry-all: ## Retry all failed jobs
	docker compose exec app php artisan queue:retry all

queue-flush: ## Flush failed jobs
	docker compose exec app php artisan queue:flush

# Testing
test: ## Run tests
	docker compose exec app php artisan test

test-coverage: ## Run tests with coverage
	docker compose exec app php artisan test --coverage

pint: ## Run code formatter
	docker compose exec app ./vendor/bin/pint

pint-test: ## Test code formatting
	docker compose exec app ./vendor/bin/pint --test

# Composer
composer-install: ## Install composer dependencies
	docker compose exec app composer install

composer-update: ## Update composer dependencies
	docker compose exec app composer update

composer-dump: ## Dump autoload
	docker compose exec app composer dump-autoload

# Bun
bun-install: ## Install bun dependencies
	docker compose exec app bun install

bun-dev: ## Run bun dev (Vite hot reload)
	bun run dev

bun-build: ## Build assets
	bun run build

bun-watch: ## Watch and rebuild assets
	bun run dev

# Database
db-shell: ## Open SQLite shell
	docker compose exec app sqlite3 database/database.sqlite

# Maintenance
fresh: down build up migrate-seed ## Fresh install with seed

clean: ## Clean containers and volumes
	docker compose down -v

reset: clean build up migrate-seed ## Complete reset

status: ## Show container status
	@docker compose ps
	@echo "\n--- Disk Usage ---"
	@docker system df
