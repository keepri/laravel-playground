<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
    @include('partials.head')

    <body>
        <main id="root">
            {{ $slot ?? '' }}
        </main>
        @include('partials.footer')
        @livewireScripts
    </body>
</html>
