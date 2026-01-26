.PHONY: help

help:
	@echo "Available commands:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

setup: ## Initialize project (install deps, generate key, migrate DB)
	@php -r "file_exists('.env') || copy('.env.example', '.env');"
	@php -r "file_exists('database/storage/database.sqlite') || touch('database/storage/database.sqlite');"
	make install
	@php artisan key:generate --ansi
	@php artisan migrate:fresh --force --ansi --seed
	npm run build
	@echo "Project successfully initialized! 🚀"

# Development
dev: ## Start all dev services (Server + Logs + Vite) - Press Ctrl+C to stop
	@echo "Starting development environment..."
	@npx concurrently -c "auto" \
		-n "server,app,vite" \
		--kill-others \
		"php artisan serve" \
		"php artisan pail -vv" \
		"npm run dev"

dev-debug: ## Start dev with Xdebug enabled (Server + Logs + Vite) - Press Ctrl+C to stop
	@./scripts/wait-for-debug-listener.sh
	@echo "Starting development environment with Xdebug..."
	@npx concurrently -c "auto" \
		-n "server,app,vite" \
		--kill-others \
		"PHP_BINARY=$(PWD)/scripts/php-debug $(PWD)/scripts/php-debug artisan serve" \
		"php artisan pail -vv" \
		"npm run dev"

xdebug-status: ## Check if Xdebug debugger is ready (IDE listening + dev-debug running)
	@echo "Checking debugger status..."
	@echo ""
	@# Check if IDE is listening on port 9003
	@if lsof -i :9003 -sTCP:LISTEN > /dev/null 2>&1; then \
		echo "IDE listener (port 9003): READY"; \
	else \
		echo "IDE listener (port 9003): NOT LISTENING"; \
		echo "  -> Start listening in PHPStorm: Run > Start Listening for PHP Debug Connections"; \
	fi
	@echo ""
	@# Check if dev-debug server is running (php-debug process with artisan serve)
	@if pgrep -f "php-debug.*artisan serve" > /dev/null 2>&1; then \
		echo "Debug server (make dev-debug): RUNNING"; \
	else \
		echo "Debug server (make dev-debug): NOT RUNNING"; \
		echo "  -> Start with: make dev-debug"; \
	fi
	@echo ""
	@# Summary
	@if lsof -i :9003 -sTCP:LISTEN > /dev/null 2>&1 && pgrep -f "php-debug.*artisan serve" > /dev/null 2>&1; then \
		echo "Status: READY - breakpoints will work"; \
	else \
		echo "Status: NOT READY - see above"; \
	fi

install: ## Install all dependencies
	composer install
	npm install
	@echo "Dependencies installed!"

pre-commit: ## Run before committing something in order to enforce code guidelines
	make refactor
	make format

# Logs
logs: ## Show Laravel logs (pail)
	@php artisan pail -vv

log-clear: ## Clear Laravel logs
	@truncate -s 0 storage/logs/*.log 2>/dev/null || true
	@echo "Laravel logs cleared"

migrate: ## Run migrations
	@php artisan migrate --seed

seed: ## Run seeders
    @php artisan db:seed

migrate-fresh: ## Fresh migrations
	@php artisan migrate:fresh --seed

migrate-rollback: ## Rollback migrations
	@php artisan migrate:rollback

tinker: ## Open tinker
	@php artisan tinker

cache-clear: ## Clear all cache
	@php artisan cache:clear
	@php artisan config:clear
	@php artisan route:clear
	@php artisan view:clear
	@php artisan optimize:clear
	@composer dump-autoload
	@echo "All caches cleared!"

# Testing
test: ## Run tests
	@php artisan config:clear --ansi
	@./vendor/bin/pest --parallel

test-coverage: ## Run tests with coverage
	@./vendor/bin/pest --parallel --coverage

format: ## Run code formatter
	./vendor/bin/pint
	npm run format

format-check: ## Test code formatting
	./vendor/bin/pint --test
	npm run format-check

refactor: ## Run Rector refactoring
	./vendor/bin/rector

analyse: ## Run static analysis
	./vendor/bin/phpstan analyse --memory-limit=2G

# Database
db-shell: ## Open SQLite shell
	@sqlite3 database/storage/database.sqlite

db-backup: ## Backup SQLite database to ./backups/
	@mkdir -p backups
	@echo "Creating database backup..."
	@tar czf backups/database-backup-$$(date +%Y%m%d-%H%M%S).tar.gz database/storage/*.sqlite* 2>/dev/null || echo 'No database files found'
	@echo "Backup completed! Check ./backups/ directory"

db-restore: ## Restore database from backup (usage: make db-restore file=database-backup-20240115-120000.tar.gz)
	@if [ -z "$(file)" ]; then \
		echo "Error: Please specify backup file. Usage: make db-restore file=database-backup-20240115-120000.tar.gz"; \
		exit 1; \
	fi
	@echo "Restoring database from $(file)..."
	@tar xzf backups/$(file) -C .
	@echo "Database restored successfully!"

# Maintenance
clean: ## Clean local artifacts (⚠️ DELETES DATABASE, node_modules, vendor!)
	@rm -rf node_modules vendor public/build
	@rm -f database/storage/database.sqlite database/storage/database.sqlite-shm database/storage/database.sqlite-wal
	@echo "Local artifacts cleaned!"

reset: ## Complete reset (⚠️ DELETES DATABASE!)
	make clean
	make setup
	@echo "Project reset complete!"
