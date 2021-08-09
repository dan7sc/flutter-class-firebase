import 'package:class_firebase/app_controller.dart';
import 'package:class_firebase/shared/auth/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    AuthController.instance.init();
    getConfiguration();
    super.initState();
  }

  Future<void> getConfiguration() async {
    final controller = AppController();

    final response = await FirebaseFirestore.instance
        .collection("/configuration")
        .doc("repository")
        .get();

    if (response.data() != null) {
      controller.repoConfiguration = response.data()!["repoConfiguration"];
    } else {
      controller.repoConfiguration = 'firebase';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Splash Page",
        ),
      ),
    );
  }
}
