import 'package:class_firebase/app_controller.dart';
import 'package:class_firebase/modules/home/home_repository.dart';
import 'package:class_firebase/modules/login/login_controller.dart';
import 'package:class_firebase/modules/login/login_repository.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = LoginController(
    repository: AppController().repoConfiguration == "firebase"
        ? LoginRepositoryImpl()
        : LoginRepositoryImplApi(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: Text('Login'),
                  onPressed: () {
                    controller.login(
                      email: 'test2@email.com',
                      password: 'asdfjk',
                    );
                  },
                ),
                TextButton(
                  child: Text('Criar conta'),
                  onPressed: () {
                    controller.createAccount(
                      user: controller.user,
                      password: 'asdjk',
                    );
                  },
                ),
                TextButton(
                  child: Text('Verificar se email existe'),
                  onPressed: () async {
                    await HomeRepository.containsEmail("test2@email.com");
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: Text('Criar transactions'),
                  onPressed: () {
                    HomeRepository.createTransaction(controller.user);
                  },
                ),
                TextButton(
                  child: Text('Busca transactions de usuario'),
                  onPressed: () {
                    HomeRepository.transactionsByUser(controller.user);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
