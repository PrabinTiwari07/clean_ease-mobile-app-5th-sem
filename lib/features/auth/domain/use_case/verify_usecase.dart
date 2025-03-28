import 'package:clean_ease/app/usecase/usecase.dart';
import 'package:clean_ease/core/error/failure.dart';
import 'package:clean_ease/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class VerifyEmailParams {
  final String email;
  final String otp;

  const VerifyEmailParams({required this.email, required this.otp});

  // Empty constructor
  const VerifyEmailParams.empty()
      : email = '_empty.email',
        otp = '_empty.otp';

  @override
  List<Object?> get props => [email, otp];
}

class VerifyEmailUsecase implements UsecaseWithParams<void, VerifyEmailParams> {
  final IAuthRepository repository;

  VerifyEmailUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(VerifyEmailParams params) {
    return repository.verifyEmail(params.email, params.otp);
  }
}
