<?php

declare(strict_types=1);

use Illuminate\Support\Facades\Route;

Route::middleware('guest')->group(function () {
    Route::get('/', fn() => view('pages.welcome'))->name('home');
});

Route::middleware('auth')->group(function () {
});

require __DIR__ . '/auth.php';
