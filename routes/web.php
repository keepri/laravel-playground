<?php

declare(strict_types=1);

use Illuminate\Support\Facades\Route;
use App\Livewire\Pages\Welcome as WelcomePage;

Route::middleware('guest')->group(function () {
    Route::get('/', WelcomePage::class)->name('home');
});

Route::middleware('auth')->group(function () {
});

require __DIR__ . '/auth.php';
