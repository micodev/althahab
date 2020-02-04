import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:mrooj_althahab/ChoicePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bloc/UsersBloc.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);
  static String route = "/login";

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final userbloc = UsersBloc();

  TextEditingController password = new TextEditingController();
  TextEditingController number = new TextEditingController();
  SharedPreferences shared;
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
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(
                  "قم بتسجيل الدخول إلى حسابك",
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
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.white),
                            icon: Icon(Icons.person, color: Colors.white),
                            labelText: "رقم الهاتف",
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
                          ),
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
                              userbloc
                                  .loginUser(number.text, password.text)
                                  .then((onValue) {
                                if (onValue.error != null) {
                                  Flushbar(
                                    title: "حصل خطأ",
                                    message: onValue.error,
                                    duration: Duration(seconds: 3),
                                  )..show(context);
                                } else {
                                  shared.setString(
                                      "api_token", "${onValue.apitoken}");
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      ChoicePage.route,
                                      (Route<dynamic> route) => false);
                                }
                              });
                            }
                          },
                          child: Text(
                            "موافق",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 17,
                                //fontFamily: "kufi",
                                fontWeight: FontWeight.w600),
                          ),
                        ),
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
