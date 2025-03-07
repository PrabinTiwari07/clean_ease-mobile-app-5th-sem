// abstract class BookingState {}

// class BookingInitial extends BookingState {}

// class BookingLoading extends BookingState {}

// class BookingSuccess extends BookingState {
//   final String message;

//   BookingSuccess(this.message);
// }

// class BookingFailure extends BookingState {
//   final String error;

//   BookingFailure(this.error);
// }

import 'package:clean_ease/features/booking/domain/entity/booking_entity.dart';
import 'package:equatable/equatable.dart';

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

class BookingHistoryLoaded extends BookingState {
  final List<BookingEntity> bookings;
  BookingHistoryLoaded(this.bookings);

  @override
  List<Object> get props => [bookings];
}
