abstract class BookingEvent {}

class CreateBookingEvent extends BookingEvent {
  final Map<String, dynamic> bookingData;

  CreateBookingEvent(this.bookingData);
}
