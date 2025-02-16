import 'dart:io';

import 'package:clean_ease/core/error/failure.dart';
import 'package:clean_ease/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repository.mock.dart';

void main() {
  late AuthRepoMock repository;
  late UploadImageUsecase usecase;

  setUp(() {
    repository = AuthRepoMock();
    usecase = UploadImageUsecase(repository);

    registerFallbackValue(File('cleanEase.png'));
  });

  final testFile = File('cleanEase.png');
  const testUrl = "images/cleanEase.png";

  test('Need to upload image and return URL on success', () async {
    when(() => repository.uploadProfilePicture(any()))
        .thenAnswer((_) async => const Right(testUrl));

    final result = await usecase(UploadImageParams(file: testFile));

    expect(result, const Right(testUrl));
    verify(() => repository.uploadProfilePicture(testFile)).called(1);
  });

  test('Need to return a Failure when upload fails', () async {
    const tFailure = ApiFailure(message: "Failed to upload image");

    when(() => repository.uploadProfilePicture(any()))
        .thenAnswer((_) async => const Left(tFailure));

    final result = await usecase(UploadImageParams(file: testFile));

    expect(result, const Left(tFailure));
    verify(() => repository.uploadProfilePicture(testFile)).called(1);
  });
}
