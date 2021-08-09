import 'package:class_firebase/modules/home/home_page.dart';
import 'package:class_firebase/modules/login/login_page.dart';
import 'package:class_firebase/modules/splash/splash_page.dart';
import 'package:class_firebase/shared/auth/auth_controller.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: AuthController.instance.navigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/splash",
      routes: {
        "/splash": (_) => SplashPage(),
        "/login": (_) => LoginPage(),
        "/home": (_) => HomePage(),
      },
    );
  }
}
