import 'package:clean_ease/features/booking/domain/use_case/booking_use_case.dart';
import 'package:clean_ease/features/booking/presentation/view_model/booking_event.dart';
import 'package:clean_ease/features/booking/presentation/view_model/booking_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final BookingUseCase bookingUseCase;

  BookingBloc({required this.bookingUseCase}) : super(BookingInitial()) {
    // Create Booking
    on<BookServiceEvent>((event, emit) async {
      emit(BookingLoading());
      print(" BookingBloc: Creating booking for service ${event.serviceId}");

      final result = await bookingUseCase.createBooking(
        serviceId: event.serviceId,
        date: event.date,
        time: event.time,
        pickupLocation: event.pickupLocation,
        dropOffLocation: event.dropOffLocation,
      );

      result.fold(
        (failure) {
          print(" BookingBloc: Booking failed - ${failure.message}");
          emit(BookingError(failure.message));
        },
        (booking) {
          print("BookingBloc: Booking created successfully - ${booking.id}");
          emit(BookingSuccess(booking));
        },
      );
    });

    // Fetch User Bookings
    on<FetchUserBookingsEvent>((event, emit) async {
      emit(BookingLoading());
      print(" BookingBloc: Fetching user bookings...");

      final result = await bookingUseCase.fetchUserBookings();

      result.fold(
        (failure) {
          print(" BookingBloc: Failed to fetch bookings - ${failure.message}");
          emit(BookingError(failure.message));
        },
        (bookings) {
          print(
              " BookingBloc: Successfully fetched ${bookings.length} bookings");
          emit(BookingHistoryLoaded(bookings));
        },
      );
    });
  }
}
