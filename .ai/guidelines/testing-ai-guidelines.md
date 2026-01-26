## Testing instructions

### General Guidelines
- Use Pest and not PHPUnit. Run tests with `php artisan test`.
  - Every test method should be structured with Arrange-Act-Assert.
  ** In the Arrange phase, 
    - use Laravel factories but add meaningful column values and variable names if they help to understand failed tests better. Bad example: `$user1 = User::factory()->create();`.Better example: `$adminUser = User::factory()->create(['email' => 'admin@admin.com'])`;
  ** In the Assert phase, perform these assertions when applicable:
    - HTTP status code returned from Act: `assertStatus()`
    - Structure/data returned from Act (Blade or JSON): functions like `assertViewHas()`, `assertSee()`, `assertDontSee()` or `assertJsonContains()`
    - Or, redirect assertions like `assertRedirect()` and `assertSessionHas()` in case of Flash session values passed
    - DB changes if any create/update/delete operation was performed: functions like `assertDatabaseHas()`, `assertDatabaseMissing()`, `expect($variable)->toBe()` and similar.

### Before Writing Tests

1. **Check database schema** - Use `database-schema` tool to understand:
    - Which columns have defaults
    - Which columns are nullable
    - Foreign key relationship names

2. **Verify relationship names** - Read the model file to confirm:
    - Exact relationship method names (not assumed from column names)
    - Return types and related models

3. **Test realistic states** - Don't assume:
    - Empty model = all nulls (check for defaults)
    - `user_id` foreign key = `user()` relationship (could be `author()`, `employer()`, etc.)
    - When testing form submissions that redirect back with errors, assert that old input is preserved using `assertSessionHasOldInput()`
- ## Testing instructions


