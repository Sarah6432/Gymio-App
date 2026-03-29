import 'package:flutter/foundation.dart';
import 'package:gymio/core/services/auth_service.dart';

class AuthViewmodel extends ChangeNotifier {
  final AuthService _authService;

  AuthViewmodel(this._authService);

  bool isLoading = false;
  String? errorMessage;

  Future<bool> signIn(String email, String password) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      await _authService.signIn(email: email, password: password);

      return true;
    } catch (e) {
      errorMessage = _mapError(e);

      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      await _authService.signInWithGoogle();
    } catch (e) {
      errorMessage = "Erro ao conectar com Google";
      notifyListeners();
    }
  }

  String _mapError(Object error) {
    if (error.toString().contains("Invalid login credentials")) {
      return "Email ou senha inválidos";
    }

    return error.toString();
  }
}
