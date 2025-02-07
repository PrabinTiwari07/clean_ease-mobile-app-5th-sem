import 'package:clean_ease/core/error/failure.dart';
import 'package:clean_ease/features/auth/domain/use_case/verify_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repository.mock.dart';

void main() {
  late AuthRepoMock repository;
  late VerifyEmailUsecase usecase;

  setUp(() {
    repository = AuthRepoMock();
    usecase = VerifyEmailUsecase(repository);
  });

  const params = VerifyEmailParams.empty();

  test('Need to return true if OTP verification success', () async {
    when(() => repository.verifyEmail(any(), any())).thenAnswer(
      (_) async => const Right(true),
    );

    final result = await usecase(params);

    expect(result, const Right(true));

    verify(() => repository.verifyEmail(params.email, params.otp)).called(1);
    verifyNoMoreInteractions(repository);
  });

  test('Need to return [Failure] when OTP verification fails', () async {
    const failure = ApiFailure(message: "OTP is incorrect");
    when(() => repository.verifyEmail(any(), any())).thenAnswer(
      (_) async => const Left(failure),
    );

    final result = await usecase(params);

    expect(result, const Left(failure));

    verify(() => repository.verifyEmail(params.email, params.otp)).called(1);
    verifyNoMoreInteractions(repository);
  });
}
