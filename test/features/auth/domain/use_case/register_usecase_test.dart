import 'package:clean_ease/core/error/failure.dart';
import 'package:clean_ease/features/auth/domain/entity/auth_entity.dart';
import 'package:clean_ease/features/auth/domain/use_case/register_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repository.mock.dart';

void main() {
  late AuthRepoMock repository;
  late RegisterUseCase registerUseCase;

  setUpAll(() {
    registerFallbackValue(const AuthEntity.empty());
  });

  setUp(() {
    repository = AuthRepoMock();
    registerUseCase = RegisterUseCase(repository);
  });

  const registerUserParams = RegisterUserParams(
    fullname: "Prabin Tiwari",
    phoneNo: "9828696552",
    address: "Jorpati",
    email: "prabintiwari44@gmail.com",
    password: "prabin123",
    image: "best.png",
  );

  group('RegisterUseCase Tests', () {
    test('Need to return failure when email is already in use', () async {
      when(() => repository.registerUser(any())).thenAnswer((_) async =>
          const Left(ApiFailure(message: "Email already registered")));

      final result = await registerUseCase(registerUserParams);

      expect(
          result, const Left(ApiFailure(message: "Email already registered")));
      verify(() => repository.registerUser(any())).called(1);
    });

    test('Need to return failure when email is invalid', () async {
      const invalidParams = RegisterUserParams(
        fullname: "Prabin Tiwari",
        phoneNo: "9828696552",
        address: "Jorpati",
        email: "prabintiwari44@gmail.com",
        password: "prabin213",
        image: "profile.png",
      );
      when(() => repository.registerUser(any())).thenAnswer(
          (_) async => const Left(ApiFailure(message: "Invalid email format")));

      final result = await registerUseCase(invalidParams);

      expect(result, const Left(ApiFailure(message: "Invalid email format")));
      verify(() => repository.registerUser(any())).called(1);
    });

    test('Need to return failure when password is too weak', () async {
      const invalidParams = RegisterUserParams(
        fullname: "Prabin Tiwari",
        phoneNo: "9828696552",
        address: "Jorpati",
        email: "prabintiwari44.com",
        password: "prabin",
        image: "profile.png",
      );
      when(() => repository.registerUser(any())).thenAnswer(
          (_) async => const Left(ApiFailure(message: "Password too weak")));

      final result = await registerUseCase(invalidParams);

      expect(result, const Left(ApiFailure(message: "Password too weak")));
      verify(() => repository.registerUser(any())).called(1);
    });

    test('Need to return failure when phone number is invalid', () async {
      const invalidParams = RegisterUserParams(
        fullname: "Prabin Tiwari",
        phoneNo: "12346549",
        address: "Jorpati",
        email: "prabintiwari44@gmail.com",
        password: "prabin123",
        image: "profile.png",
      );
      when(() => repository.registerUser(any())).thenAnswer(
          (_) async => const Left(ApiFailure(message: "Invalid phone number")));

      final result = await registerUseCase(invalidParams);

      expect(result, const Left(ApiFailure(message: "Invalid phone number")));
      verify(() => repository.registerUser(any())).called(1);
    });

    test('Need to return Failure when there is a server error', () async {
      when(() => repository.registerUser(any())).thenAnswer((_) async =>
          const Left(ApiFailure(message: "Internal Server Error")));

      final result = await registerUseCase(registerUserParams);

      expect(result, const Left(ApiFailure(message: "Internal Server Error")));
      verify(() => repository.registerUser(any())).called(1);
    });

    test('Successfully registers the user', () async {
      when(() => repository.registerUser(any()))
          .thenAnswer((_) async => const Right(null));

      final result = await registerUseCase(registerUserParams);

      expect(result, const Right(null));
      verify(() => repository.registerUser(any())).called(1);
    });
  });
}
