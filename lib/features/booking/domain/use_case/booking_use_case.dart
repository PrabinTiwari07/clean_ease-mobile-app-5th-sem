import 'package:clean_ease/core/error/failure.dart';
import 'package:clean_ease/features/booking/domain/entity/booking_entity.dart';
import 'package:clean_ease/features/booking/domain/repository/booking_repository.dart';
import 'package:dartz/dartz.dart';

class BookingUseCase {
  final BookingRepository bookingRepository;

  BookingUseCase({required this.bookingRepository});

  Future<Either<Failure, BookingEntity>> createBooking({
    required String serviceId,
    required String date,
    required String time,
    required String pickupLocation,
    required String dropOffLocation,
  }) async {
    try {
      final booking = await bookingRepository.createBooking({
        "serviceId": serviceId,
        "date": date,
        "time": time,
        "pickupLocation": pickupLocation,
        "dropOffLocation": dropOffLocation,
      });

      return Right(booking);
    } catch (error) {
      return const Left(ServerFailure(message: "Booking created successfully"));
    }
  }

  Future<Either<Failure, List<BookingEntity>>> fetchUserBookings() async {
    try {
      final bookings = await bookingRepository.fetchUserBookings();
      return Right(bookings);
    } catch (error) {
      return const Left(ServerFailure(message: "Failed to fetch bookings"));
    }
  }
}
