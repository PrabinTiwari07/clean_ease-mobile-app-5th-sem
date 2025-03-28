// Mocks generated by Mockito 5.4.5 from annotations
// in clean_ease/test/features/service/presentation/view_model/service_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:clean_ease/core/error/failure.dart' as _i6;
import 'package:clean_ease/features/service/domain/entity/service_entity.dart'
    as _i7;
import 'package:clean_ease/features/service/domain/repository/service_repository.dart'
    as _i2;
import 'package:clean_ease/features/service/domain/use_case/service_use_case.dart'
    as _i4;
import 'package:dartz/dartz.dart' as _i3;
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

class _FakeIServiceRepository_0 extends _i1.SmartFake
    implements _i2.IServiceRepository {
  _FakeIServiceRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_1<L, R> extends _i1.SmartFake implements _i3.Either<L, R> {
  _FakeEither_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [GetServicesUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetServicesUseCase extends _i1.Mock
    implements _i4.GetServicesUseCase {
  MockGetServicesUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.IServiceRepository get serviceRepository => (super.noSuchMethod(
        Invocation.getter(#serviceRepository),
        returnValue: _FakeIServiceRepository_0(
          this,
          Invocation.getter(#serviceRepository),
        ),
      ) as _i2.IServiceRepository);

  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.ServiceEntity>>> call() =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [],
        ),
        returnValue:
            _i5.Future<_i3.Either<_i6.Failure, List<_i7.ServiceEntity>>>.value(
                _FakeEither_1<_i6.Failure, List<_i7.ServiceEntity>>(
          this,
          Invocation.method(
            #call,
            [],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, List<_i7.ServiceEntity>>>);
}
