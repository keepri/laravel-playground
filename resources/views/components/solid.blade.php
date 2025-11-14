@props([
    'fragment' => false,
    'name' => '',
    'props' => '{}'
])

<div
    @if($fragment) style="display: contents;" @endif
    solid-component="{{ $name }}"
    solid-props="{{ $props }}"
    {{ $attributes }}
></div>
