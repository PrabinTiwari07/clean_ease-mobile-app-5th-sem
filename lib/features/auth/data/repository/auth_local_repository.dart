import '../data_source/auth_local_data_source.dart';

class AuthLocalRepository {
  final AuthLocalDataSource _localDataSource;

  AuthLocalRepository(this._localDataSource);

  /// Register a new user
  Future<void> registerUser(String email, String password) async {
    final existingPassword = _localDataSource.getUserPassword(email);
    if (existingPassword != null) {
      throw Exception("User already exists");
    }
    await _localDataSource.saveUserCredentials(email, password);
  }

  /// Login an existing user
  bool loginUser(String email, String password) {
    final storedPassword = _localDataSource.getUserPassword(email);
    if (storedPassword == null) {
      throw Exception("User does not exist");
    }
    return storedPassword == password;
  }
}
