import 'dart:async';

import 'package:mrooj_althahab/models/Orders.dart';
import 'package:mrooj_althahab/repository/AppRepository.dart';

class OrdersBloc {
  final int con;
  final AppRepository appRepo = AppRepository();
  final _orderController = StreamController<List<Orders>>.broadcast();
  Stream<List<Orders>> get orders => _orderController.stream;
  OrdersBloc({this.con}) {
    getOrders(con);
  }
  Future<Orders> addOrder(Orders order) async {
    var ord = await appRepo.createOrder(order);
    await getOrders(con);
    return ord;
  }

  Future getOrders(int con) async {
    _orderController.sink.add(await appRepo.getOrders(con));
  }

  dispose() {
    _orderController.close();
  }
}
