import '../../domain/use_case/login_use_case.dart';
// import '../../domain/use_case/register_use_case.dart';

class AuthViewModel {
  // final RegisterUseCase _registerUseCase;
  final LoginUseCase _loginUseCase;

  // AuthViewModel(this._registerUseCase, this._loginUseCase);
  AuthViewModel(this._loginUseCase);

  /// Handles user registration
  Future<String?> register(String email, String password) async {
    try {
      // await _registerUseCase.call(email, password);
      return null; // Registration successful
    } catch (e) {
      return e.toString(); // Return error message
    }
  }

  /// Handles user login
  String? login(String email, String password) {
    try {
      final isSuccess = _loginUseCase.call(email, password);
      return isSuccess ? null : "Invalid email or password";
    } catch (e) {
      return e.toString(); // Return error message
    }
  }
}
