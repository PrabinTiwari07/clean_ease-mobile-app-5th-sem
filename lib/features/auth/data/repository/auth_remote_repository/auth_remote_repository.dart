import 'dart:io';

import 'package:clean_ease/core/error/failure.dart';
import 'package:clean_ease/features/auth/data/data_source/remote_data_source/auth_remote_data_source.dart';
import 'package:clean_ease/features/auth/domain/entity/auth_entity.dart';
import 'package:clean_ease/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRemoteRepository implements IAuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRemoteRepository(this._authRemoteDataSource);

  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> loginUser(
      String email, String password) async {
    try {
      // Call the remote data source to handle the login API call
      final token = await _authRemoteDataSource.loginUser(email, password);
      return Right(token);
    } catch (e) {
      // If an error occurs, wrap it in a Failure and return as Left
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> registerUser(AuthEntity user) async {
    try {
      await _authRemoteDataSource.registerUser(user);
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) async {
    try {
      final imageName = await _authRemoteDataSource.uploadProfilePicture(file);
      return Right(imageName);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> verifyEmail(String email, String otp) async {
    try {
      await _authRemoteDataSource.verifyEmail(email, otp);
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
