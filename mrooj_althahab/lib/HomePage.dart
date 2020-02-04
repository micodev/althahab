import 'package:flutter/material.dart';
import 'package:mrooj_althahab/LoginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ChoicePage.dart';
import 'RegisterPage.dart';

class HomePage extends StatefulWidget {
  static String route = "/";
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final comName = "شركة مروج الذهب";
  final about =
      "يستعمل هذا التطبيق في مساعدة كل من \nيريد أن يدخل في عالم التسوق الألكتروني";
  @override
  void initState() {
    loadingRefrence().then((v) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.blue[100],
          ),
          position: DecorationPosition.background,
          child: Center(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 90, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(comName,
                    style: TextStyle(
                        fontSize: 35,
                        fontFamily: "kufi",
                        fontWeight: FontWeight.w600)),
                SizedBox(
                  height: 55,
                ),
                Text(
                  about,
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontFamily: "kufi",
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 75,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: RaisedButton(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed(LoginPage.route);
                          },
                          child: Text(
                            "تسجيل دخول",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                                fontFamily: "kufi",
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: RaisedButton(
                          color: Colors.white.withAlpha(220),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed(RegisterPage.route);
                          },
                          child: Text(
                            "أنشاء حساب",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                                fontFamily: "kufi",
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ))),
    );
  }

  SharedPreferences prefs;
  Future loadingRefrence() async {
    prefs = await SharedPreferences.getInstance();
    String apitoken = (prefs.getString('api_token') ?? "");
    if (apitoken != "") {
      Navigator.of(context).pushNamedAndRemoveUntil(
          ChoicePage.route, (Route<dynamic> route) => false);
    }
  }
}
