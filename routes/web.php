<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\CampaignController;

Route::inertia('/', 'Welcome')->name('home');

Route::middleware(['auth', 'verified'])->group(function () {
    Route::inertia('dashboard', 'Dashboard')->name('dashboard');
    Route::post('/campaigns', [CampaignController::class, 'create'])->name('campaigns.create');
});

require __DIR__.'/settings.php';
