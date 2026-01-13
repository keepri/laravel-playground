<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
    <x-partials.head />

    <body>
        <main id="root">
            {{ $slot ?? '' }}
        </main>
        <x-partials.footer />
        @livewireScripts
    </body>
</html>

