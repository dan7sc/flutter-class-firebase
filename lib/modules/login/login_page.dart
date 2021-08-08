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
          .set({"email": user.email, "created": FieldValue.serverTimestamp()});
      print('CreateUser: $user');
    } catch (e) {
      print('ErrorCreateUser: $e');
    }
  }

  Future<bool> containsEmail(String email) async {
    try {
      final response = await FirebaseFirestore.instance
          .collection("/users")
          .where("email", isEqualTo: email)
          .where("created", isGreaterThanOrEqualTo: DateTime(2021, 7, 29))
          .get();
      print('ContainsEmail: ${response.docs.length > 0}');
      return response.docs.length > 0;
    } catch (e) {
      print('ErrorContainsEmail: $e');
      throw e;
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
            ),
            TextButton(
              child: Text('Verificar se email existe'),
              onPressed: () async {
                await containsEmail("test2@email.com");
              },
            ),
          ],
        ),
      ),
    );
  }
}
