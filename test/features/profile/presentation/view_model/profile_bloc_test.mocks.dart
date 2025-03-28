// Mocks generated by Mockito 5.4.5 from annotations
// in clean_ease/test/features/profile/presentation/view_model/profile_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:clean_ease/features/profile/domain/entity/profile_entity.dart'
    as _i3;
import 'package:clean_ease/features/profile/domain/repository/profile_repository.dart'
    as _i2;
import 'package:clean_ease/features/profile/domain/use_case/get_profile_use_case.dart'
    as _i4;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeProfileRepository_0 extends _i1.SmartFake
    implements _i2.ProfileRepository {
  _FakeProfileRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeProfileEntity_1 extends _i1.SmartFake implements _i3.ProfileEntity {
  _FakeProfileEntity_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [GetProfileUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetProfileUseCase extends _i1.Mock implements _i4.GetProfileUseCase {
  MockGetProfileUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.ProfileRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeProfileRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.ProfileRepository);

  @override
  _i5.Future<_i3.ProfileEntity> call() => (super.noSuchMethod(
        Invocation.method(
          #call,
          [],
        ),
        returnValue: _i5.Future<_i3.ProfileEntity>.value(_FakeProfileEntity_1(
          this,
          Invocation.method(
            #call,
            [],
          ),
        )),
      ) as _i5.Future<_i3.ProfileEntity>);
}
