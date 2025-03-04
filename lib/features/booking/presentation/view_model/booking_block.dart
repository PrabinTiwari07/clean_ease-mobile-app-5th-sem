import 'package:bloc/bloc.dart';
import 'package:clean_ease/features/booking/domain/entity/booking_entity.dart';
import 'package:clean_ease/features/booking/domain/use_case/booking_use_case.dart';
import 'package:equatable/equatable.dart';

// Define Events
abstract class BookingEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class BookServiceEvent extends BookingEvent {
  final String serviceId;
  final String date;
  final String time;
  final String pickupLocation;
  final String dropOffLocation;

  BookServiceEvent({
    required this.serviceId,
    required this.date,
    required this.time,
    required this.pickupLocation,
    required this.dropOffLocation,
  });

  @override
  List<Object> get props =>
      [serviceId, date, time, pickupLocation, dropOffLocation];
}

// Define States
abstract class BookingState extends Equatable {
  @override
  List<Object> get props => [];
}

class BookingInitial extends BookingState {}

class BookingLoading extends BookingState {}

class BookingSuccess extends BookingState {
  final BookingEntity booking;
  BookingSuccess(this.booking);

  @override
  List<Object> get props => [booking];
}

class BookingError extends BookingState {
  final String message;
  BookingError(this.message);

  @override
  List<Object> get props => [message];
}

// Booking Bloc
class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final BookingUseCase bookingUseCase;

  BookingBloc({required this.bookingUseCase}) : super(BookingInitial()) {
    on<BookServiceEvent>((event, emit) async {
      emit(BookingLoading());

      final result = await bookingUseCase.createBooking(
        serviceId: event.serviceId,
        date: event.date,
        time: event.time,
        pickupLocation: event.pickupLocation,
        dropOffLocation: event.dropOffLocation,
      );

      result.fold(
        (failure) => emit(BookingError(failure.message)),
        (booking) => emit(BookingSuccess(booking)),
      );
    });
  }
}
