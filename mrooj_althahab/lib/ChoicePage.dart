import 'package:flutter/material.dart';
import 'package:mrooj_althahab/ActiveOrder.dart';
import 'package:mrooj_althahab/HomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'BackOrder.dart';
import 'DileverdOrder.dart';

class ChoicePage extends StatefulWidget {
  ChoicePage({Key key}) : super(key: key);
  static final route = "/Choices";
  @override
  _ChoicePageState createState() => _ChoicePageState();
}

class _ChoicePageState extends State<ChoicePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () {
              setState(() {
                logOut(context);
              });
            },
            icon: Icon(Icons.exit_to_app),
          )
        ],
        title: Text(
          "صفحة الأختيارات",
          style: TextStyle(
              fontSize: 20, fontFamily: "kufi", fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    elevation: 20,
                    color: Colors.blue[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: naviagteto1,
                    child: Text(
                      "الطلبات",
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    elevation: 20,
                    color: Colors.blue[50],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: naviagteto2,
                    child: Text(
                      "الطلبات الواصلة",
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    elevation: 20,
                    color: Colors.grey[50],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: naviagteto3,
                    child: Text(
                      "الطلبات الراجعة",
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
      ),
    );
  }

  void naviagteto1() {
    Navigator.of(context).pushNamed(ActiveOrder.route);
  }

  void naviagteto2() {
    Navigator.of(context).pushNamed(DileverdOrder.route);
  }

  void naviagteto3() {
    Navigator.of(context).pushNamed(BackOrder.route);
  }

  Future logOut(BuildContext context) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    shared.setString("api_token", "");
    Navigator.of(context).pushNamedAndRemoveUntil(
        HomePage.route, (Route<dynamic> route) => false);
  }
}
