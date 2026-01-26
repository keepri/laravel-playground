## Filament General Rules

- When generating Filament resource, you MUST generate Filament smoke tests to check if the Resource works. When making changes to Filament resource, you MUST run the tests (generate them if they don't exist) and make changes to resource/tests to make the tests pass.
- When generating Filament resource, don't generate View page or Infolist, unless specifically instructed.
- When referencing the Filament routes, aim to use `getUrl()` instead of Laravel `route()`. Instead of `route('filament.admin.resources.class-schedules.index')`, use `ClassScheduleResource::getUrl('index')`. Also, specify the exacy Resource name, instead of `getResource()`.
- When writing tests with Pest, use syntax `Livewire::test(class)` and not `livewire(class)`, to avoid extra dependency on `pestphp/pest-plugin-livewire`.
- When using Enum class for Eloquent Model field, use Enum `HasLabel`, `HasColor` and `HasIcon` instead of specifying values/labels/colors/icons inside of Filament Forms/Tables. Refer to this docs page: https://filamentphp.com/docs/4.x/advanced/enums

---

## Filament Version 4 Rules

List of important changes in Filament v4 vs Filament v3:

- Validation rule `unique()` has `ignoreRecord: true` by default, no need to specify it.
- Don't use full namespaces when referencing Filament classes like `Filament\Forms\Components\DatePicker`. Always put the namespaces in `use` section on top and use only classname instead of full path.
- If you create custom Blade files with Tailwind classes, you need to create a custom theme and specify the folder of those Blade files in theme.css.
- Table Filters have `->schema()` instead of `->form()`
- `Action::make()` has `->schema()` instead of `->form()`
- Table has `->toolbarActions()` instead of `->bulkActions()`
- `Get`, `Set`, and other form utilities are now in `Filament\Schemas\Components\Utilities\Get` and not in `Filament\Forms\Get`
- Layout Components Moved: Grid, Section, Fieldset, etc. are now in `Filament\Schemas\Components\` and not in `Filament\Forms\Components\`
