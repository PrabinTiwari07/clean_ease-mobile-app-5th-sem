import 'package:hive/hive.dart';

class AuthLocalDataSource {
  final Box _authBox;

  AuthLocalDataSource(this._authBox);

  /// Save user credentials
  Future<void> saveUserCredentials(String email, String password) async {
    await _authBox.put(email, password);
  }

  /// Retrieve password for the given email
  String? getUserPassword(String email) {
    return _authBox.get(email); // Returns null if email doesn't exist
  }
}
