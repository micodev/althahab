<?php

namespace App\Http\Controllers;

use App\Order;
use App\User;
use Illuminate\Support\Facades\Auth;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Carbon\Carbon;

class OrderController extends Controller
{
    public function Index(Request $request, $condition)
    {
        $user = Auth::user();
        $order = $user->Orders()->where("condition", "=", $condition)->get();
        return response()->json($order, 200);
    }
    public function changeOrder(Request $request)
    {
        $order_id = $request->query("orderId");
        $cond = $request->query("cond");
        $order = Order::find($order_id);
        if ($cond == 1) {
            $user = $order->user;
            $balance = $user->balance + $order->cost;
            $user->update(['balance' => $balance]);
        }
        $order->update(['condition' => $cond]);
        return response()->json($order, 200);
    }
    public function getOrders(Request $request)
    {
        $order = Order::all();
        return response()->json($order, 200);
    }
    public function create(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'checkId' => ['required', 'string'],
            'customer_number' => ['required', 'string', 'max:11'],
            'cost' => ['required', 'min:3'],
        ]);
        if ($validator->fails()) {
            return response()->json($validator->messages(), 201);
        }
        $order_parms = $request->only('customer_number', 'cost', 'checkId');
        $user = Auth::user();
        $order = $user->Orders()->create(
            [
                'checkId' => $order_parms["checkId"],
                'customer_number' => $order_parms["customer_number"],
                'cost' => $order_parms["cost"],
                'created_at' => Carbon::today()->toDateString()
            ]
        );
        return response()->json($order, 200);
    }
    public function deleteOrders(Request $request)
    {
        $date = Carbon::now()->addDay(-7);
        return  Order::where('created_at', "<", $date)->where("condition", "<>", 0)->delete();
    }
    public function getUserOrders(Request $request)
    {
        $userid = $request->query("user_id");
        $order = User::find($userid)->Orders;
        return response()->json($order, 200);
    }
}