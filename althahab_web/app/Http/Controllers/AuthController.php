<?php

namespace App\Http\Controllers;

use App\User;
use Illuminate\Http\Request;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

class AuthController extends Controller
{
    public function authenticate(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'number' => ['required', 'string', 'max:11'],
            'password' => ['required', 'string', 'min:8'],
        ]);
        if ($validator->fails()) {
            return response()->json($validator->messages(), 201);
        }
        $credentials = $request->only('number', 'password');

        if (Auth::attempt($credentials)) {
            // Authentication passed...

            return response()->json(Auth::user(), 200);
        } else {

            return response()->json(["error" => "not authunicated", 201]);
        }
    }

    public function register(Request $request)
    {

        $credentials = $request->only('name', 'number', 'password');
        $validator = Validator::make($credentials, [
            'name' => ['required', 'string', 'max:255'],
            'number' => ['required', 'string', 'max:11', 'unique:users'],
            'password' => ['required', 'string', 'min:8'],
        ]);
        if ($validator->fails()) {
            return response()->json($validator->messages(), 201);
        }
        $api_token = $credentials['number'] . ":" . Str::random(60);
        User::create([
            'name' => $credentials['name'],
            'number' => $credentials['number'],
            'password' => Hash::make($credentials['password']),
            'api_token' => $api_token
        ]);
        return response()->json(["api_token" => $api_token], 200);
    }

    public function getUsers(Request $request)
    {
        $user = User::all();
        return response()->json($user, 200);
    }
    public function changeBalance(Request $request)
    {
        $id = $request->query("id");
        $amount = $request->query("amount");
        $user = User::find($id);
        $user->update(['balance' => $user->balance - $amount]);
        return response()->json($user, 200);
    }
}