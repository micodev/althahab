<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Order extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    public $timestamps = false;
    protected $fillable = ['customer_number', 'cost', 'condition', 'checkId', 'created_at'];
    public function user()
    {
        return $this->belongsTo('App\User');
    }
    public $hidden = ['user_id'];
}