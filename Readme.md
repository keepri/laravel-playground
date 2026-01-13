# Laravel Playground — short guide

A small Laravel starter workspace configured with common developer tooling for formatting, static analysis, refactoring and frontend tooling. The commands below show what each tool does, why it's useful, and how to run it locally.

## Quick start

```bash
composer run setup
```
- Project bootstrap and a convenient dev aggregator.
- Benefit: Sets up environment, DB, installs deps and runs local dev tasks.

OR manually:
- Install PHP/composer deps (local):
```bash
composer install
```
- Install node deps (local):
```bash
npm install
```
- Run dev (Vite) (local):
```bash
npm run dev
```
- Build assets (local):
```bash
npm run build
```



## Composer-scripted tools
```bash
composer run format
```
- Runs Laravel Pint (PHP formatter) and the frontend format script.
- Benefit: Keeps PHP code consistent and readable across the team.

```bash
composer run format:check
```
  - Runs Pint in "check" mode + frontend format check (no changes).
  - Benefit: Use in CI to fail when formatting drifts.


```bash
composer run rector
```
  - Runs Rector (automated PHP refactorings) then Pint.
  - Benefit: Automates safe upgrades and repetitive refactors; saves manual work.


```bash
composer run analyse
```
  - Runs PHPStan / Larastan static analysis.
  - Benefit: Finds type/logic issues early; use at high level (e.g. level 5).


```bash
composer run ptest
```
  - Runs Pest tests in parallel; composer test runs PHPUnit via Artisan.
  - Benefit: Fast, expressive tests (Pest) and compatibility with PHPUnit.

```bash
composer run test
```
  - Runs PHPUnit tests via Artisan.
  - Benefit: Compatibility with PHPUnit ecosystem.



## Frontend / package.json tools

```bash
npm run format
```
  - blade-formatter (formats blade templates) and rustywind (sorts Tailwind classes).
  - Benefit: Consistent Blade markup and deterministic Tailwind class order.

```bash
npm run format:check
```
  -Same tools in "check" mode to detect unformatted files.
  - Benefit: CI friendly; fail on style drift.


- npm run dev / npm run build
  - What: Start Vite dev server or build production assets.
  - Benefit: Fast HMR in development and optimized assets for production.
  - Run dev (local):
```bash
npm run dev
```
  - Build (local):
```bash
npm run build
```

- Other scripts
  - clean / clean-install: helpers to remove node_modules and reinstall (useful for fixing broken installs).
  - Run clean (local):
```bash
npm run clean
```
  - Run clean-install (local):
```bash
npm run clean-install
```

## Recommended workflows
- Before committing (local):
```bash
composer run format && composer run rector && composer run analyse && composer run ptest
```

- Local development:
```bash
make up
composer run dev
npm run dev
```

## Notes
-
