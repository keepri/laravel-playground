<?php

declare(strict_types=1);

use App\Livewire\Pages\Welcome as WelcomePage;
use Illuminate\Support\Facades\Route;

Route::middleware('guest')->group(function () {
    Route::get('/', WelcomePage::class)->name('home');
});

Route::middleware('auth')->group(function () {
});

require __DIR__ . '/auth.php';
