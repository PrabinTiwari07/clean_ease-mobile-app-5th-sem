import 'package:bloc_test/bloc_test.dart';
import 'package:clean_ease/core/error/failure.dart';
import 'package:clean_ease/features/booking/domain/entity/booking_entity.dart';
import 'package:clean_ease/features/booking/domain/use_case/booking_use_case.dart';
import 'package:clean_ease/features/booking/presentation/view_model/booking_bloc.dart';
import 'package:clean_ease/features/booking/presentation/view_model/booking_event.dart';
import 'package:clean_ease/features/booking/presentation/view_model/booking_state.dart';
import 'package:clean_ease/features/service/domain/entity/service_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'booking_bloc_test.mocks.dart';

@GenerateMocks([BookingUseCase])
void main() {
  late BookingBloc bookingBloc;
  late MockBookingUseCase mockBookingUseCase;

  late ServerFailure fakeFailure;
  late BookingEntity fakeBooking;

  setUp(() {
    mockBookingUseCase = MockBookingUseCase();
    bookingBloc = BookingBloc(bookingUseCase: mockBookingUseCase);

    fakeFailure = const ServerFailure(message: 'Test failure message');

    fakeBooking = BookingEntity(
      id: '123',
      service: ServiceEntity(
        serviceId: 'service_001',
        title: 'Laundry Service',
        category: 'Home Services',
        price: 15.0,
        description: 'Reliable laundry service',
        image: 'https://example.com/image.jpg',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      userId: 'user_001',
      date: '2025-03-04',
      time: '10:00 AM',
      pickupLocation: 'Location A',
      dropOffLocation: 'Location B',
      status: 'Confirmed',
    );
  });

  tearDown(() {
    bookingBloc.close();
  });

  test('Initial state should be BookingInitial', () {
    expect(bookingBloc.state, BookingInitial());
  });

  blocTest<BookingBloc, BookingState>(
    'emits [BookingLoading, BookingSuccess] when BookServiceEvent succeeds',
    build: () {
      when(mockBookingUseCase.createBooking(
        serviceId: anyNamed('serviceId'),
        date: anyNamed('date'),
        time: anyNamed('time'),
        pickupLocation: anyNamed('pickupLocation'),
        dropOffLocation: anyNamed('dropOffLocation'),
      )).thenAnswer((_) async => Right(fakeBooking));

      return bookingBloc;
    },
    act: (bloc) => bloc.add(BookServiceEvent(
      serviceId: '1',
      date: '2025-03-04',
      time: '10:00 AM',
      pickupLocation: 'Location A',
      dropOffLocation: 'Location B',
    )),
    expect: () => [
      BookingLoading(),
      BookingSuccess(fakeBooking),
    ],
  );

  blocTest<BookingBloc, BookingState>(
    'emits [BookingLoading, BookingError] when BookServiceEvent fails',
    build: () {
      when(mockBookingUseCase.createBooking(
        serviceId: anyNamed('serviceId'),
        date: anyNamed('date'),
        time: anyNamed('time'),
        pickupLocation: anyNamed('pickupLocation'),
        dropOffLocation: anyNamed('dropOffLocation'),
      )).thenAnswer((_) async => Left(fakeFailure));

      return bookingBloc;
    },
    act: (bloc) => bloc.add(BookServiceEvent(
      serviceId: '1',
      date: '2025-03-04',
      time: '10:00 AM',
      pickupLocation: 'Location A',
      dropOffLocation: 'Location B',
    )),
    expect: () => [
      BookingLoading(),
      isA<BookingError>(),
    ],
  );

  blocTest<BookingBloc, BookingState>(
    'emits [BookingLoading, BookingHistoryLoaded] when FetchUserBookingsEvent succeeds',
    build: () {
      when(mockBookingUseCase.fetchUserBookings())
          .thenAnswer((_) async => Right([fakeBooking]));

      return bookingBloc;
    },
    act: (bloc) => bloc.add(FetchUserBookingsEvent()),
    expect: () => [
      BookingLoading(),
      BookingHistoryLoaded([fakeBooking]),
    ],
  );

  blocTest<BookingBloc, BookingState>(
    'emits [BookingLoading, BookingError] when FetchUserBookingsEvent fails',
    build: () {
      when(mockBookingUseCase.fetchUserBookings())
          .thenAnswer((_) async => Left(fakeFailure));

      return bookingBloc;
    },
    act: (bloc) => bloc.add(FetchUserBookingsEvent()),
    expect: () => [
      BookingLoading(),
      isA<BookingError>(),
    ],
  );

  blocTest<BookingBloc, BookingState>(
    'does not emit new states when no event is added',
    build: () => bookingBloc,
    expect: () => [],
  );
}
