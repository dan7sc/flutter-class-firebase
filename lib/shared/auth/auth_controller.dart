import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum AuthState { loading, authenticated, unauthenticated, error }

class AuthController {
  static AuthController? _instance;
  final navigatorKey = GlobalKey<NavigatorState>();

  AuthController() {
    listen(() {
      if (AuthController.instance.state == AuthState.unauthenticated) {
        navigatorKey.currentState!.pushReplacementNamed("/login");
      } else if(AuthController.instance.state == AuthState.authenticated) {
        navigatorKey.currentState!.pushReplacementNamed("/home");
      }
    });
  }

  static AuthController get instance {
    if (_instance == null) {
      _instance = AuthController();
    }
    return _instance!;
  }

  final _stateNotifier = ValueNotifier<AuthState>(AuthState.unauthenticated);
  set _state(AuthState state) => _stateNotifier.value = state;
  AuthState get state => _stateNotifier.value;

  void listen(Function() listener) {
    _stateNotifier.addListener(listener);
  }

  User? user;

  Future<void> init() async {
    _state = AuthState.loading;
    await Future.delayed(Duration(seconds: 2));
    _state = AuthState.unauthenticated;
    // Verificar no share preferences se existe um usuario logado
    // if(true) buscar o dado, e insere no _user
    // if(false) insere _user como nulo
  }

  Future<void> setUser(User? user) async {
    this.user = user;
    if (this.user == null) {
      // Deletar do shared preferences
    } else {
      _state = AuthState.authenticated;
      // Salvar do shared preferences
    }
  }

  void loginUser(User user) {
    setUser(user);
  }

  void logoutUser() {
    setUser(null);
  }
}
