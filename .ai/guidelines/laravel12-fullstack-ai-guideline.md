You are an expert in PHP, Laravel 12, and full-stack development using Blade for frontend rendering. You write secure, testable, maintainable Laravel apps following official conventions and best practices.
## General code instructions
- Don't generate code comments above the methods or code blocks if they are obvious. Don't add docblock comments when defining variables, unless instructed to, like `/** @var \App\Models\User $currentUser */`. Generate comments only for something that needs extra explanation for the reasons why that code was written.
- For library documentation, if some library is not available in Laravel Boost 'search-docs', always use context7. Automatically use the Context7 MCP tools to resolve library id and get library docs without me having to explicitly ask.
- Use Laravel helpers instead of `use` section classes. Examples: use `auth()->id()` instead of `Auth::id()` and adding `Auth` in the `use` section. Other examples: use `redirect()->route()` instead of `Redirect::route()`, or `str()->slug()` instead of `Str::slug()`.
- Import all classes with `use` and reference only their short names; no fully-qualified class names in code.

## PHP Best Practices
- Use `declare(strict_types=1)` for strict typing.
- Avoid `var_dump`, use logging or `dd()` only in dev.
- Use type-hinting and return types.
- Use `readonly` properties and early returns.
- In PHP, use `match` operator over `switch` whenever possible
- Generate Enums always in the folder `app/Enums`, not in the main `app/` folder, unless instructed differently.
- Don't create temporary variables like `$currentUser = auth()->user()` if that variable is used only one time.
- Enums: If a PHP Enum exists for a domain concept, always use its cases (or their `->value`) instead of raw strings everywhere — routes, middleware, migrations, seeds, configs, and UI defaults.

## Laravel Structure
- Follow PSR-4 and default Laravel folder structure.
- Use `artisan` commands (`make:model`, `make:controller`, `make:request`).
- Avoid unnecessary abstraction in small/medium projects.
- I am using Laravel Herd locally, so always assume that the main URL of the project is `http://[folder_name].test`

## Routing
- Use `Route::resource` or `Route::apiResource`.
- Group by middleware (`auth`, `web`, `api`) and prefixes.
- Use route model binding; avoid closures in routes.

## Controllers
- Aim for "slim" Controllers and put larger logic pieces in Service classes
- When generating Controllers, put validation in Form Request classes and use `$request->validated()` instead of listing inputs one by one.
- Using Services in Controllers: if Service class is used only in ONE method of Controller, inject it directly into that method with type-hinting. If Service class is used in MULTIPLE methods of Controller, initialize it in Constructor.
- Return JSON or views as appropriate.
- Use invokable controllers for single-use cases.
- Controllers: Single-method Controllers should use `__invoke()`; multi-method RESTful controllers should use `Route::resource()->only([])`
- Don't create Controllers with just one method which just returns `view()`. Instead, use `Route::view()` with Blade file directly.

## Models
- Use `$fillable` or `$guarded`.
- Define relationships clearly.
- Use `$casts` and query scopes.
- Add accessors and mutators for transformations.
- **Eloquent Observers** should be registered in Eloquent Models with PHP Attributes, and not in AppServiceProvider. Example: `#[ObservedBy([UserObserver::class])]` with `use Illuminate\Database\Eloquent\Attributes\ObservedBy;` on top

## Requests & Validation
- Use `FormRequest` classes.
- Use `authorize()` for access checks.
- Use reusable rules or custom Rule objects.

## Eloquent
- Don't use `whereKey()` or `whereKeyNot()`, use specific fields like `id`. Example: instead of `->whereKeyNot($currentUser->getKey())`, use `->where('id', '!=', $currentUser->id)`.
- Don't add `::query()` when running Eloquent `create()` statements. Example: instead of `User::query()->create()`, use `User::create()`.

## Blade Views
- Avoid business logic in templates.
- Use `@extends`, `@section`, `@include`, `@props`.
- Escape all output (`{{ }}`), only use `{!! !!}` when needed.
- Use components for reusability.
- In Livewire projects, don't use Livewire Volt. Only Livewire class components.

## API Resources
- Use `JsonResource` or `ResourceCollection`.
- Return proper HTTP codes (e.g. `201`, `204`, `422`).
- Hide sensitive data (e.g. passwords, tokens).


## Authentication
- Use Laravel Breeze, Jetstream, or Fortify.
- Use Sanctum for token-based APIs.
- Use middleware (`auth`, `throttle`, `can`) for protection.

## Authorization
- Use Policies for model-level access.
- Register policies in `AuthServiceProvider`.
- Use Gates for general checks.
- Use `authorize()` or `can()` in controllers and views.

## Testing
- Use PHPUnit with `php artisan test`.
- Use feature and unit tests.
- Use factories and `RefreshDatabase`.

## Jobs & Queues
- Use `make:job` and dispatch via `dispatch()`.
- Handle retries and failures.
- Use Horizon for queue management.

## Database
- For DB pivot tables, use correct alphabetical order, like "project_role" instead of "role_project"
- When creating pivot tables in migrations, if you use `timestamps()`, then in Eloquent Models, add `withTimestamps()` to the `BelongsToMany` relationships.

## Migrations & Seeders
- Use `foreignId()->constrained()` for relations.
- Add indexes.
- Use seeders and factories for dev/testing.
- When adding columns in a migration, update the model's `$fillable` array to include those new attributes.
- Never chain multiple migration-creating commands (e.g., `make:model -m`, `make:migration`) with `&&` or `;` — they may get identical timestamps. Run each command separately and wait for completion before running the next.

## Performance
- Use Redis/Memcached for cache.
- Use `Cache::remember()` for heavy queries.
- Run `config:cache`, `route:cache` in production.
- Consider Laravel Octane.

## Events & Observers
- Use observers for model hooks.
- Use events to decouple logic.
- Queue listeners for heavy operations.
- **Eloquent Observers** should be registered in Eloquent Models with PHP Attributes, and not in AppServiceProvider. Example: `#[ObservedBy([UserObserver::class])]` with `use Illuminate\Database\Eloquent\Attributes\ObservedBy;` on top
