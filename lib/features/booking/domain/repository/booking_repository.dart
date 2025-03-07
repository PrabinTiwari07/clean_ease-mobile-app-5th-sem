import 'package:clean_ease/features/booking/domain/entity/booking_entity.dart';

abstract class BookingRepository {
  Future<BookingEntity> createBooking(Map<String, dynamic> bookingData);
  Future<List<BookingEntity>> fetchUserBookings(); // ✅ Added method
}
