<?php

use Illuminate\Support\Facades\Route;
use Inertia\Inertia;
use App\Http\Controllers\AccountController;

Route::get('/', function () {
    return redirect()->route('login');
});

Route::middleware(['auth', 'verified'])->group(function () {
    Route::get('/app', function () {
        return Inertia::render('App/Home');
    })->name('dashboard');

    // Account pages
    Route::get('/account', function () {
        return Inertia::location(route('account.profile'));
    })->name('account');

    Route::get('/account/profile', function () {
        return Inertia::render('App/Account/Profile/Index');
    })->name('account.profile');

    Route::get('/account/password', function () {
        return Inertia::render('App/Account/Password/Index');
    })->name('account.password');

    Route::patch('/account/profile', [AccountController::class, 'updateProfile'])
        ->name('account.profile.update');
});

require __DIR__.'/auth.php';