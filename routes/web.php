<?php

use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});

Route::get('/cool-people', function (Request $request) {
    return json([
        "ian",
        "jaimie",
        "david",
    ]);
});