import 'package:class_firebase/shared/auth/auth_controller.dart';
import 'package:class_firebase/shared/models/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginRepository {
  Future<void> createAccount({
    required UserData user,
    required String password,
  });

  Future<UserData?> login({
    required String email,
    required String password,
  });

  Future<bool>? recoveryPassword({
    required String password,
  });
}

class LoginRepositoryImpl extends LoginRepository {
  @override
  Future<void> createAccount({
    required UserData user,
    required String password,
  }) async {
    try {
      final response = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: "test2@email.com", password: "asdfjk");
      final _user = response.user;

      Map<String, dynamic> _userMap = user.toMap();

      await FirebaseFirestore.instance
          .collection("/users")
          .doc(_user!.uid)
          .set(_userMap);
      // .set({"email": user.email, "created": FieldValue.serverTimestamp()});

      print('CreateUser: $user');
    } catch (e) {
      print('ErrorCreateUser: $e');
    }
  }

  @override
  Future<UserData?> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      AuthController.instance.loginUser(response.user!);
      final getUser = await FirebaseFirestore.instance
          .collection("/users")
          .doc(response.user!.uid)
          .get();
      print('SignInUser: ${getUser.data()}');
      if (getUser.data() != null) {
        return UserData.fromMap(getUser.data()!);
      } else {
        throw 'Usuário não encontrado';
      }
    } catch (e) {
      print('ErrorSignInUser: $e');
      return null;
    }
  }
  Future<bool>? recoveryPassword({
    required String password,
  }) {}
}

class LoginRepositoryImplApi extends LoginRepository {
  @override
  Future<void> createAccount({
    required UserData user,
    required String password,
  }) {
    // TODO: implement createAccount
    throw UnimplementedError();
  }

  @override
  Future<UserData?> login({
    required String email,
    required String password,
  }) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<bool>? recoveryPassword({
    required String password,
  }) {
    // TODO: implement recoveryPassword
    throw UnimplementedError();
  }
}
