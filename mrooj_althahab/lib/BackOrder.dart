import 'package:flutter/material.dart';
import 'package:mrooj_althahab/models/Orders.dart';

import 'bloc/OrdersBloc.dart';

class BackOrder extends StatefulWidget {
  BackOrder({Key key}) : super(key: key);
  static final route = "/BackOrder";

  @override
  _BackOrderState createState() => _BackOrderState();
}

class _BackOrderState extends State<BackOrder> {
  static int conId = 2;
  final orderBloc = OrdersBloc(con: conId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("الطلبات الراجعة",
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
            scrollDirection: Axis.horizontal,
            child: DataTable(
              rows: list
                  .map((f) => DataRow(cells: <DataCell>[
                        DataCell(Text(f.checkId.toString(),
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: "kufi",
                                fontWeight: FontWeight.bold))),
                        DataCell(Text(f.customNumber,
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: "kufi",
                                fontWeight: FontWeight
                                    .bold))), //Extracting from Map element the value
                        DataCell(Text(f.cost.toString(),
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: "kufi",
                                fontWeight: FontWeight.bold))),
                        DataCell(Text(f.date,
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: "kufi",
                                fontWeight: FontWeight.bold))),
                      ]))
                  .toList(),
              columns: [
                DataColumn(
                  label: Text("رقم الوصل",
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: "kufi",
                          fontWeight: FontWeight.bold)),
                ),
                DataColumn(
                  label: Text("رقم الزبون",
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: "kufi",
                          fontWeight: FontWeight.bold)),
                ),
                DataColumn(
                  label: Text("السعر",
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: "kufi",
                          fontWeight: FontWeight.bold)),
                ),
                DataColumn(
                  label: Text("التاريخ",
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: "kufi",
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void refreshTablbe() {
    orderBloc.getOrders(conId);
  }
}
