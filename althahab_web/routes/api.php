<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::post('login', "AuthController@authenticate");
Route::post('signup', "AuthController@register");
Route::middleware('auth:api')->get('/balance', function (Request $request) {

    return response()->json(["balance" => $request->user()->balance], 200);
});
Route::middleware('auth:api')->get('/order/{condition}', "OrderController@index");
Route::middleware('auth:api')->post('/order', "OrderController@create");
Route::get('/order', "OrderController@getOrders");
Route::get('/getuserorder', "OrderController@getUserOrders");
Route::get('/user', "AuthController@getUsers");
Route::get('/deleteOrders', "OrderController@deleteOrders");
Route::middleware('auth:api')->get('/getuser', function (Request $request) {
    return $request->user();
});

Route::get('/changeBalance', "AuthController@changeBalance");
Route::get('/changeOrder', "OrderController@changeOrder");
Route::get("error", function (Request $request) {
    return response()->json(["error" => "not authenicated"], 201);
})->name("error");