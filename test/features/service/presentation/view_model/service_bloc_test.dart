import 'package:bloc_test/bloc_test.dart';
import 'package:clean_ease/core/error/failure.dart';
import 'package:clean_ease/features/service/domain/entity/service_entity.dart';
import 'package:clean_ease/features/service/domain/use_case/service_use_case.dart';
import 'package:clean_ease/features/service/presentation/view_model/service_bloc.dart';
import 'package:clean_ease/features/service/presentation/view_model/service_event.dart';
import 'package:clean_ease/features/service/presentation/view_model/service_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'service_bloc_test.mocks.dart';

/// ✅ Generate mocks for `GetServicesUseCase`
@GenerateMocks([GetServicesUseCase])
void main() {
  late ServiceBloc serviceBloc;
  late MockGetServicesUseCase mockGetServicesUseCase;

  /// ✅ Fake service list
  final List<ServiceEntity> fakeServices = [
    ServiceEntity(
      serviceId: '1',
      title: 'Laundry Service',
      category: 'Cleaning',
      price: 15.0,
      description: 'Fast and reliable laundry service',
      image: 'https://example.com/laundry.jpg',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    ServiceEntity(
      serviceId: '2',
      title: 'Plumbing Service',
      category: 'Repair',
      price: 50.0,
      description: 'Professional plumbing solutions',
      image: 'https://example.com/plumbing.jpg',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];

  /// ✅ Failure case
  const failure = ServerFailure(message: 'Failed to fetch services');

  setUp(() {
    mockGetServicesUseCase = MockGetServicesUseCase();
    serviceBloc = ServiceBloc(getServicesUseCase: mockGetServicesUseCase);
  });

  tearDown(() {
    serviceBloc.close();
  });

  /// ✅ **Test 1: Initial state should be `ServiceInitial`**
  test('Initial state should be ServiceInitial', () {
    expect(serviceBloc.state, ServiceInitial());
  });

  /// ✅ **Test 2: Successful Fetch Services**
  blocTest<ServiceBloc, ServiceState>(
    'emits [ServiceLoading, ServicesLoaded] when GetServicesEvent succeeds',
    build: () {
      when(mockGetServicesUseCase())
          .thenAnswer((_) async => Right(fakeServices));
      return serviceBloc;
    },
    act: (bloc) => bloc.add(GetServicesEvent()),
    expect: () => [
      ServiceLoading(),
      ServicesLoaded(services: fakeServices),
    ],
  );

  /// ✅ **Test 3: Fetch Services Failure**
  blocTest<ServiceBloc, ServiceState>(
    'emits [ServiceLoading, ServiceError] when GetServicesEvent fails',
    build: () {
      when(mockGetServicesUseCase())
          .thenAnswer((_) async => const Left(failure));
      return serviceBloc;
    },
    act: (bloc) => bloc.add(GetServicesEvent()),
    expect: () => [
      ServiceLoading(),
      ServiceError(
          message: failure.toString()), // ✅ EXPECTS THE FULL FAILURE OBJECT
    ],
  );
}
