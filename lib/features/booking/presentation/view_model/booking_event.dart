// abstract class BookingEvent {}

// class CreateBookingEvent extends BookingEvent {
//   final Map<String, dynamic> bookingData;

//   CreateBookingEvent(this.bookingData);
// }

import 'package:equatable/equatable.dart';

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

class FetchUserBookingsEvent extends BookingEvent {}
