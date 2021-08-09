import 'package:class_firebase/modules/login/login_repository.dart';
import 'package:class_firebase/shared/models/user_data.dart';

class LoginController {
  final LoginRepository repository;

  late UserData user;

  LoginController({
    required this.repository,
  });

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    final response = await repository.login(
      email: email,
      password: password,
    );

    print("RESPONSE: $response");
    if (response != null) {
      user = response;
      return true;
    }

    return false;
  }

  Future<void> createAccount({
    required UserData user,
    required String password,
  }) async {
    await repository.createAccount(
      user: user,
      password: password,
    );
  }
}
