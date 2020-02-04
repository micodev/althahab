<?php

use Illuminate\Support\Facades\Route;
use Illuminate\Http\Request;
/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/getuserorderview', function (Request $request) {
    $userid = $request->query("user_id");
    if($userid!=null){
    return view('userorder');
    }
    else {
       return view('orders');
    }
});
Route::get('/', function () {
    return view('orders');
});
Route::get('/orders', function () {
    return view('orders');
})->name('order');
Route::get('/users', function () {
    return view('users');
})->name('user');
// Auth::routes();

// Route::get('/home', 'HomeController@index')->name('home');