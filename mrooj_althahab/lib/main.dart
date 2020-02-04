import 'package:flutter/material.dart';
import 'package:mrooj_althahab/ActiveOrder.dart';
import 'package:mrooj_althahab/BackOrder.dart';
import 'package:mrooj_althahab/HomePage.dart';
import 'package:mrooj_althahab/LoginPage.dart';
import 'package:mrooj_althahab/RegisterPage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'ChoicePage.dart';
import 'DileverdOrder.dart';

void main() {
  //SharedPreferences.setMockInitialValues(<String, dynamic>{'api_token': ""});
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale("ar", "IR"), // OR Locale('ar', 'AE') OR Other RTL locales
      ],
      locale: Locale("fa", "IR"),
      theme: ThemeData(
          // Use the old theme but apply the following three changes
          textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'kufi',
              fontSizeDelta: 8,
              bodyColor: Colors.white,
              displayColor: Colors.white)),
      initialRoute: HomePage.route,
      routes: {
        HomePage.route: (_) => HomePage(),
        RegisterPage.route: (_) => RegisterPage(),
        LoginPage.route: (_) => LoginPage(),
        ActiveOrder.route: (_) => ActiveOrder(),
        DileverdOrder.route: (_) => DileverdOrder(),
        BackOrder.route: (_) => BackOrder(),
        ChoicePage.route: (_) => ChoicePage()
      },
    );
  }
}
