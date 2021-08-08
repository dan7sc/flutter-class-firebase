import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<void> login() async {
    try {
      final response = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: "test@email.com", password: "asdfjk");
      final user = response.user;
      print('SignInUser: $user');
    } catch (e) {
      print('ErrorSignInUser: $e');
    }
  }

  Future<void> createAccount() async {
    try {
      final response = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: "test2@email.com", password: "asdfjk");
      final user = response.user;
      await FirebaseFirestore.instance
          .collection("/users")
          .doc(user!.uid)
          .set({"email": user.email});
      print('CreateUser: $user');
    } catch (e) {
      print('ErrorCreateUser: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: Text('Login'),
              onPressed: () {
                login();
              },
            ),
            TextButton(
              child: Text('Criar conta'),
              onPressed: () {
                createAccount();
              },
            )
          ],
        ),
      ),
    );
  }
}
