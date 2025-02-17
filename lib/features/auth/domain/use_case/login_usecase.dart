// import 'package:dartz/dartz.dart';
// import 'package:equatable/equatable.dart';

// import '../../../../app/usecase/usecase.dart';
// import '../../../../core/error/failure.dart';
// import '../repository/auth_repository.dart';

// class LoginParams extends Equatable {
//   final String email;
//   final String password;

//   const LoginParams({
//     required this.email,
//     required this.password,
//   });

//   const LoginParams.initial()
//       : email = '',
//         password = '';

//   @override
//   List<Object> get props => [email, password];
// }

// class LoginUseCase implements UsecaseWithParams<String, LoginParams> {
//   final IAuthRepository repository;

//   LoginUseCase(this.repository);

//   @override
//   Future<Either<Failure, String>> call(LoginParams params) {
//     return repository.loginUser(params.email, params.password);
//   }
// }

import 'package:clean_ease/app/shared_prefs/token_shared_prefs.dart';
import 'package:clean_ease/app/usecase/usecase.dart';
import 'package:clean_ease/core/error/failure.dart';
import 'package:clean_ease/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({
    required this.email,
    required this.password,
  });

  // Initial Constructor
  const LoginParams.initial()
      : email = '',
        password = '';

  @override
  List<Object> get props => [email, password];
}

class LoginUseCase implements UsecaseWithParams<String, LoginParams> {
  final IAuthRepository repository;
  final TokenSharedPrefs tokenSharedPrefs;

  LoginUseCase(this.repository, this.tokenSharedPrefs);

  @override
  Future<Either<Failure, String>> call(LoginParams params) async {
    final result = await repository.loginUser(params.email, params.password);

    return result.fold(
      (failure) => Left(failure), // Return failure if login fails
      (token) async {
        await tokenSharedPrefs.saveToken(token);
        final savedToken = await tokenSharedPrefs.getToken();
        print(savedToken);
        return Right(token);
      },
    );
  }
}
