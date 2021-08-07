import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:class_firebase/app_widget.dart';

class FirebaseWidget extends StatefulWidget {
  @override
  _FirebaseWidgetState createState() => _FirebaseWidgetState();
}

class _FirebaseWidgetState extends State<FirebaseWidget> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Deu erro no firebase"),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return AppWidget();
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
