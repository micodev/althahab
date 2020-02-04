import 'package:mrooj_althahab/databaseaccess/OrdersAccess.dart';
import 'package:mrooj_althahab/databaseaccess/UsersAccess.dart';
import 'package:mrooj_althahab/models/ApiToken.dart';
import 'package:mrooj_althahab/models/Orders.dart';
import 'package:mrooj_althahab/models/Users.dart';

class AppRepository {
  final userAccess = UsersAccess();
  final orderAccess = OrdersAccess();
  //user access
  Future<ApiToken> createUser(Users user) => userAccess.createUser(user);
  Future<Users> loginUser(String number, String password) =>
      userAccess.loginUser(number, password);
  Future<Users> getBalance() => userAccess.getBalance();

  //order access
  Future<Orders> createOrder(Orders order) => orderAccess.createOrder(order);
  Future<List<Orders>> getOrders(int con) => orderAccess.getOrders(con);
}
