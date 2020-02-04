import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:mrooj_althahab/models/Orders.dart';

import 'bloc/OrdersBloc.dart';
import 'bloc/UsersBloc.dart';

class DileverdOrder extends StatefulWidget {
  DileverdOrder({Key key}) : super(key: key);
  static final route = "/DileverdOrder";

  @override
  _DileverdOrderState createState() => _DileverdOrderState();
}

class _DileverdOrderState extends State<DileverdOrder> {
  static int conId = 1;
  final orderBloc = OrdersBloc(con: conId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("الطلبات الواصلة",
            style: TextStyle(
                fontSize: 20, fontFamily: "kufi", fontWeight: FontWeight.bold)),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: refreshTablbe,
          ),
        ],
      ),
      body: StreamBuilder<List<Orders>>(
        stream: orderBloc.orders,
        //print an integer every 2secs, 10 times
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<Orders> list = snapshot.data;
          return SingleChildScrollView(
            child: DataTable(
              rows: list
                  .map((f) => DataRow(cells: <DataCell>[
                        DataCell(Text(f.checkId.toString())),
                        DataCell(Text(f.cost.toString())),
                      ]))
                  .toList(),
              columns: [
                DataColumn(
                  label: Text("رقم الوصل",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "kufi",
                          fontWeight: FontWeight.bold)),
                ),
                DataColumn(
                  label: Text("السعر",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "kufi",
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          UsersBloc().getbalance().then((user) {
            if (user.error != null) {
              Flushbar(
                title: "حدث خطأ",
                message: user.error,
                duration: Duration(seconds: 3),
              )..show(context);
            } else {
              Flushbar(
                title: "رصيدك هو",
                message: " ${user.balance} IQD",
                duration: Duration(seconds: 3),
              )..show(context);
            }
          });
        },
        elevation: 20,
        child: Icon(Icons.attach_money),
      ),
    );
  }

  void refreshTablbe() {
    orderBloc.getOrders(conId);
  }
}
