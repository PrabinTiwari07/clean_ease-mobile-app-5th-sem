import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {
  final LoginUseCase loginUseCase;
  final SignupUseCase signupUseCase;

  AuthViewModel(this.loginUseCase, this.signupUseCase);

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> login(String email, String password) async {
    try {
      return await loginUseCase.execute(email, password);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> signup(String email, String password) async {
    try {
      return await signupUseCase.execute(email, password);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }
}
