import 'package:clean_ease/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenSharedPrefs {
  final SharedPreferences _sharedPreferences;

  TokenSharedPrefs(this._sharedPreferences);

  Future<Either<Failure, void>> saveToken(String token) async {
    try {
      await _sharedPreferences.setString('token', token);
      return const Right(null);
    } catch (e) {
      return Left(
          SharedPrefsFailure(message: "Failed to save token: ${e.toString()}"));
    }
  }

  ///  Get Token from SharedPreferences
  Future<Either<Failure, String>> getToken() async {
    try {
      final token = _sharedPreferences.getString('token');
      if (token != null && token.isNotEmpty) {
        return Right(token);
      } else {
        return const Left(SharedPrefsFailure(message: "No token found"));
      }
    } catch (e) {
      return Left(SharedPrefsFailure(
          message: "Failed to retrieve token: ${e.toString()}"));
    }
  }

  ///  Clear Token (Logout)
  Future<Either<Failure, void>> clearToken() async {
    try {
      await _sharedPreferences.remove('token');
      return const Right(null);
    } catch (e) {
      return Left(SharedPrefsFailure(
          message: "Failed to clear token: ${e.toString()}"));
    }
  }
}
