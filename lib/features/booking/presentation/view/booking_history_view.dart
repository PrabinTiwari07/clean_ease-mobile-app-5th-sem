import 'package:clean_ease/app/di/di.dart';
import 'package:clean_ease/core/common/navigator.dart';
import 'package:clean_ease/features/booking/presentation/view_model/booking_bloc.dart';
import 'package:clean_ease/features/booking/presentation/view_model/booking_event.dart';
import 'package:clean_ease/features/booking/presentation/view_model/booking_state.dart';
import 'package:clean_ease/features/home/presentation/home.dart';
import 'package:clean_ease/features/home/presentation/view/bottom_view.dart/calendar.dart';
import 'package:clean_ease/features/profile/presentation/view/profile_view.dart';
import 'package:clean_ease/features/service/presentation/view/service_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingHistoryView extends StatelessWidget {
  const BookingHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          BookingBloc(bookingUseCase: getIt())..add(FetchUserBookingsEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("My Bookings"),
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
        ),
        body: BlocBuilder<BookingBloc, BookingState>(
          builder: (context, state) {
            if (state is BookingLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is BookingError) {
              return Center(child: Text("Error: ${state.message}"));
            } else if (state is BookingHistoryLoaded) {
              if (state.bookings.isEmpty) {
                return const Center(child: Text("No bookings found"));
              }
              return LayoutBuilder(
                builder: (context, constraints) {
                  return GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: constraints.maxWidth > 600 ? 2 : 1,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: constraints.maxWidth > 600 ? 1.8 : 1.4,
                    ),
                    itemCount: state.bookings.length,
                    itemBuilder: (context, index) {
                      final booking = state.bookings[index];
                      return BookingCard(booking: booking);
                    },
                  );
                },
              );
            }
            return const Center(child: Text("Fetching booking history..."));
          },
        ),

        // ✅ Bottom Navigation Bar (Responsive Navigation)
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: 4, // ✅ Highlights "My Booking" tab
          onTap: (index) {
            if (index != 4) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) {
                  if (index == 0) return const Home();
                  if (index == 1) return const Calendar();
                  if (index == 2) return const ServiceListScreen();
                  if (index == 3) return const ProfileView();
                  return const BookingHistoryView();
                }),
                (route) => false,
              );
            }
          },
        ),
      ),
    );
  }
}

class BookingCard extends StatelessWidget {
  final dynamic booking;
  const BookingCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Responsive Image
            if (booking.service.image.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  'http://192.168.1.71:3000${booking.service.image}',
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 8),

            // ✅ Service Title
            Text(
              booking.service.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),

            // ✅ Service Price
            Text(
              "Price: \$${booking.service.price.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 4),

            // ✅ Service Category
            Text(
              "Category: ${booking.service.category}",
              style: const TextStyle(fontSize: 14, color: Colors.grey),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),

            // ✅ Description (Limited lines)
            Text(
              booking.service.description,
              style: const TextStyle(fontSize: 14),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),

            // ✅ Booking Date & Time
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Date: ${booking.date} | Time: ${booking.time}",
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),

            // ✅ Drop-off Location
            Text(
              "Drop-off: ${booking.dropOffLocation}",
              style: const TextStyle(fontSize: 14),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),

            // ✅ Booking Status
            Text(
              "Status: ${booking.status.toUpperCase()}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: booking.status == "pending"
                    ? Colors.orange
                    : booking.status == "confirmed"
                        ? Colors.green
                        : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
