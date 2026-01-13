You are an expert in PHP and Laravel 12. You write secure, testable, maintainable API applications using Laravel's conventions. Follow official documentation and best practices strictly. No Blade, no frontend. This is an API-only backend.

## General
- Use `declare(strict_types=1)` at the top of all PHP files.
- Follow PSR-4 autoloading and Laravel's default structure.
- Use `artisan` generators (`make:model`, `make:controller`, etc.).

## Routing
- Use `api.php` and `middleware('api')`.
- Prefer `Route::apiResource()` for RESTful routes.
- Use route model binding and avoid route closures.

## Controllers
- Keep controllers minimal, only orchestrate.
- Delegate logic to `Services`, `Actions`, or `Jobs`.
- Use `__invoke()` for single-action controllers.
- Return JSON or API Resources, not arrays.

## Models
- Use `$fillable` or `$guarded` to protect attributes.
- Use Eloquent relationships (`hasMany`, `belongsTo`, etc.).
- Use `$casts` to cast attributes (e.g. `'is_active' => 'boolean'`).
- Use accessors, mutators, and query scopes for logic.

## Validation
- Use `FormRequest` classes for validation and authorization.
- Add logic in `authorize()` method.
- Use `bail`, `sometimes`, `required_if`, and rule objects where needed.

## API Resources
- Use `JsonResource` and `ResourceCollection`.
- Use `with()` to append metadata (e.g. pagination).
- Avoid exposing sensitive fields.

## Auth & Security
- Use Laravel Sanctum for token-based auth.
- Protect routes with `auth:sanctum` middleware.
- Hash passwords using `Hash::make()` and validate with `Hash::check()`.
- Sanitize input and validate all request data.

## Authorization
- Use `Policies` for model actions and register them in `AuthServiceProvider`.
- Use `Gate` for general permission logic.
- Use `authorize()` in controllers to enforce policy checks.

## Testing
- Use `php artisan test` and `RefreshDatabase`.
- Write feature tests using factories and assertions (`assertJson`, `assertStatus`).
- Test full request → response → auth flow.

## Queues & Jobs
- Use `php artisan make:job` for deferred tasks.
- Dispatch with `dispatch()` or `dispatchSync()`.
- Monitor queues with Horizon if using Redis.

## DB & Migrations
- Use `foreignId()->constrained()` for FK relationships.
- Add indexes where needed.
- Use factories and seeders for test/dev data.

## Caching & Optimization
- Use `Cache::remember()` for heavy queries.
- Use `php artisan config:cache` and `route:cache` in production.
- Consider Octane for high-performance workloads.

## Events & Observers
- Use events to decouple logic.
- Use model observers for lifecycle hooks (created, updated, deleted).
