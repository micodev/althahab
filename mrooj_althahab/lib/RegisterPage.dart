import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:mrooj_althahab/ChoicePage.dart';
import 'package:mrooj_althahab/models/Users.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/UsersBloc.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);
  static String route = "/register";

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  SharedPreferences shared;
  final userbloc = UsersBloc();
  TextEditingController name = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController number = new TextEditingController();
  @override
  void initState() {
    SharedPreferences.getInstance().then((share) {
      shared = share;
    });
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "قم بأنشاء الحساب الخاص بك",
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: "kufi",
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 20,
                              fontFamily: "kufi",
                              fontWeight: FontWeight.bold),
                          textDirection: TextDirection.rtl,
                          decoration: InputDecoration(
                              labelStyle: TextStyle(color: Colors.white),
                              icon: Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                              labelText: "أسم المستخدم",
                              hintText: "عبدالله معروف"),
                          validator: (String value) {
                            if (value.length == 0)
                              return "يرجى أدخال أسم المستخدم";
                            if (value.contains('@')) return 'أدخال خاطىء';

                            return null;
                          },
                          maxLength: 20,
                          controller: name,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.white),
                            icon: Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                            labelText: "رقم الهاتف",
                            hintText: "07xxxxxxxxx",
                          ),
                          validator: (String value) {
                            Pattern pattern = "^[0-9]+\$";
                            RegExp regex = new RegExp(pattern);
                            if (value.length == 0)
                              return "يرجى أدخال رقم الهاتف";
                            else if (!regex.hasMatch(value))
                              return "يرجى أدخال الأرقام فقط";
                            else if (value.length < 11)
                              return "يرجى أدخال رقم صحيح";
                            return null;
                          },
                          maxLength: 11,
                          controller: number,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              labelStyle: TextStyle(color: Colors.white),
                              icon: Icon(Icons.person, color: Colors.white),
                              labelText: "كلمة المرور",
                              hintText: "*************"),
                          validator: (String value) {
                            Pattern pattern =
                                "^(((?=.*[a-z])(?=.*[A-Z]))|((?=.*[a-z])(?=.*[0-9]))|((?=.*[A-Z])(?=.*[0-9])))(?=.{6,})";

                            RegExp regex = new RegExp(pattern);
                            if (value.length < 6)
                              return "يجب أن يحتوي على أقل 6 أرقام";
                            else if (!regex.hasMatch(value))
                              return "يجب أن تتكون كلمة المرور من حروف وأرقام ورموز";
                            return null;
                          },
                          maxLength: 16,
                          controller: password,
                        ),
                        SizedBox(
                          height: 45,
                        ),
                        RaisedButton(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          onPressed: () {
                            if (formKey.currentState.validate()) {
                              Users user = Users(
                                  name: name.text,
                                  number: number.text,
                                  password: password.text);
                              userbloc.addUser(user).then((v) {
                                if (v != null && v.apitoken != null) {
                                  shared.setString(
                                      "api_token", "${v.apitoken}");
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      ChoicePage.route,
                                      (Route<dynamic> route) => false);
                                } else {
                                  Flushbar(
                                    title: "حصل خطأ",
                                    message: v.error,
                                    duration: Duration(seconds: 3),
                                  )..show(context);
                                }
                              });
                            }
                          },
                          child: Text(
                            "موافق",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                                fontFamily: "kufi",
                                fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
