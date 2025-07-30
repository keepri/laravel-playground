<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">

@include('partials.head')

<body>
    {{ $slot ?? '' }}
    @include('partials.footer')
    @livewireScripts
</body>

</html>
