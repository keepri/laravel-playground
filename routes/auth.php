<?php

use App\Http\Controllers\Auth\VerifyEmailController;
use App\Livewire\Actions\Logout;
use Illuminate\Support\Facades\Route;

Route::middleware('guest')->group(function () {});

Route::middleware('auth')->group(function () {
    Route::get('verify-email/{id}/{hash}', VerifyEmailController::class)
        ->middleware(['signed', 'throttle:6,1'])
        ->name('verification.verify');
});

Route::post('logout', Logout::class)->name('logout');
