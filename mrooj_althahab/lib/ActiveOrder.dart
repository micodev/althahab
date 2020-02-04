import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:mrooj_althahab/models/Orders.dart';
import 'bloc/OrdersBloc.dart';

class ActiveOrder extends StatefulWidget {
  ActiveOrder({Key key}) : super(key: key);
  static final route = "/ActiveOrder";

  @override
  _ActiveOrderState createState() => _ActiveOrderState();
}

class _ActiveOrderState extends State<ActiveOrder> {
  static int conId = 0;
  final orderBloc = OrdersBloc(con: conId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("الطلبات الفعالة",
            style: TextStyle(
                fontSize: 20, fontFamily: "kufi", fontWeight: FontWeight.bold)),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: addSheetButtons,
          ),
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
                        DataCell(Text(f.checkId.toString())),
                        DataCell(Text(f
                            .customNumber)), //Extracting from Map element the value
                        DataCell(Text(f.cost.toString())),
                        DataCell(Text(f.date)),
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

  final formKey = GlobalKey<FormState>();
  final customerNumber = TextEditingController();
  final cost = TextEditingController();
  final checkId = TextEditingController();
  void addSheetButtons() {
    setState(() {
      customerNumber.text = "";
      cost.text = "";
      checkId.text = "";
    });
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5, bottom: 15),
                    child: TextFormField(
                      controller: checkId,
                      textInputAction: TextInputAction.newline,
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 21,
                          color: Colors.black54,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'kufi'),
                      autofocus: true,
                      decoration: const InputDecoration(
                          hintText: 'مثال : 1999813326',
                          labelText: 'اضف رقم الوصل',
                          labelStyle: TextStyle(
                              color: Colors.indigoAccent,
                              fontWeight: FontWeight.w500)),
                      validator: (String value) {
                        Pattern pattern = "^[0-9]+\$";
                        RegExp regex = new RegExp(pattern);
                        if (value.length == 0)
                          return "يرجى أدخال رقم الهاتف";
                        else if (!regex.hasMatch(value))
                          return "يرجى أدخال الأرقام فقط";

                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5, bottom: 15),
                    child: TextFormField(
                      controller: customerNumber,
                      textInputAction: TextInputAction.newline,
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 21,
                          color: Colors.black54,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'kufi'),
                      autofocus: true,
                      decoration: const InputDecoration(
                          hintText: 'مثال : 07701231234',
                          labelText: 'اضف رقم زبون',
                          labelStyle: TextStyle(
                              color: Colors.indigoAccent,
                              fontWeight: FontWeight.w500)),
                      validator: (String value) {
                        Pattern pattern = "^[0-9]+\$";
                        RegExp regex = new RegExp(pattern);
                        if (value.length == 0)
                          return "يرجى أدخال رقم الهاتف";
                        else if (!regex.hasMatch(value))
                          return "يرجى أدخال الأرقام فقط";
                        else if (value.length < 11)
                          return "يرجى أدخال رقم صحيح";
                        else if (value.length < 11 || value.length > 11)
                          return "يرجى أدخال 11 رقم فقط";
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5, bottom: 15),
                    child: TextFormField(
                      controller: cost,
                      textInputAction: TextInputAction.newline,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54,
                      ),
                      autofocus: true,
                      decoration: const InputDecoration(
                          hintText: 'مثال : 5000',
                          labelText: 'ادخل سعر الطلب',
                          labelStyle: TextStyle(
                              color: Colors.indigoAccent,
                              fontWeight: FontWeight.w500)),
                      validator: (String value) {
                        Pattern pattern = "^[0-9]+\$";
                        RegExp regex = new RegExp(pattern);
                        if (value.length == 0)
                          return "يرجى أدخال رقم";
                        else if (!regex.hasMatch(value))
                          return "يرجى أدخال الأرقام فقط";

                        return null;
                      },
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Colors.indigoAccent,
                            radius: 18,
                            child: IconButton(
                              icon: Icon(
                                Icons.save,
                                size: 22,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                if (formKey.currentState.validate()) {
                                  Orders order = new Orders(
                                      customNumber: customerNumber.text,
                                      checkId: checkId.text,
                                      cost: int.parse(cost.text));
                                  orderBloc.addOrder(order).then((v) {
                                    if (v.error != null) {
                                      Navigator.of(context).pop();
                                      Flushbar(
                                        title: "حدث خطأ",
                                        message: v.error,
                                        duration: Duration(seconds: 3),
                                      )..show(context);
                                    } else {
                                      Navigator.of(context).pop();
                                      Flushbar(
                                        title: "تم أضافه",
                                        message: "مبروك تمت اضافه الطلب",
                                        duration: Duration(seconds: 3),
                                      )..show(context);
                                    }
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      )),
                  SizedBox(height: 10),
                ],
              ),
            )));
  }

  void refreshTablbe() {
    orderBloc.getOrders(conId);
  }
}
