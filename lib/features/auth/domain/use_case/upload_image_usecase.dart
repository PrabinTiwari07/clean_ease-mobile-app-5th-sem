import 'dart:io';

import 'package:clean_ease/app/usecase/usecase.dart';
import 'package:clean_ease/core/error/failure.dart';
import 'package:clean_ease/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class UploadImageParams {
  final File file;
  const UploadImageParams({
    required this.file,
  });
}

class UploadImageUsecase
    implements UsecaseWithParams<String, UploadImageParams> {
  final IAuthRepository _repository;

  UploadImageUsecase(this._repository);

  @override
  Future<Either<Failure, String>> call(UploadImageParams params) {
    return _repository.uploadProfilePicture(params.file);
  }
}
