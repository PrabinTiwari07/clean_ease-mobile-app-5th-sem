import 'package:clean_ease/app/di/di.dart';
import 'package:clean_ease/features/booking/presentation/view_model/booking_block.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class BookingView extends StatefulWidget {
  final String serviceId;
  const BookingView({super.key, required this.serviceId});

  @override
  _BookingViewState createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  void _pickDateTime(BuildContext context) async {
    // Pick a Date
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      // Pick a Time
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          selectedDate = pickedDate;
          selectedTime = pickedTime;
        });
      }
    }
  }

  void _confirmBooking(BuildContext context, String serviceId) {
    if (selectedDate == null || selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a date and time!")),
      );
      return;
    }

    final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate!);
    final formattedTime = selectedTime!.format(context);

    context.read<BookingBloc>().add(
          BookServiceEvent(
            serviceId: widget.serviceId,
            date: formattedDate,
            time: formattedTime,
            pickupLocation: "User's Address",
            dropOffLocation: "Service Location",
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<BookingBloc>(), // ✅ Inject `BookingBloc` directly
      child: Scaffold(
        appBar: AppBar(title: const Text("Booking Page")),
        body: BlocConsumer<BookingBloc, BookingState>(
          listener: (context, state) {
            if (state is BookingSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text("Booking Confirmed Successfully!")),
              );
              Future.delayed(const Duration(seconds: 2), () {
                Navigator.pop(context);
              });
            } else if (state is BookingError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Booking for: Service",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  const Text("Price: \$9.00",
                      style: TextStyle(fontSize: 16, color: Colors.green)),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _pickDateTime(context),
                    child: Text(selectedDate == null || selectedTime == null
                        ? "Select Date & Time"
                        : "Selected: ${DateFormat('yyyy-MM-dd').format(selectedDate!)} at ${selectedTime!.format(context)}"),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _confirmBooking(context, "service_id_123"),
                    child: const Text("Confirm Booking"),
                  ),
                  if (state is BookingLoading)
                    const CircularProgressIndicator(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// import 'package:clean_ease/features/booking/presentation/view_model/booking_block.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../view_model/booking_event.dart';
// import '../view_model/booking_state.dart';

// class BookingView extends StatelessWidget {
//   final String userId;
//   final String serviceId; // ✅ Backend expects serviceId, not serviceTitle
//   final String date;
//   final String time;

//   const BookingView({
//     super.key,
//     required this.userId,
//     required this.serviceId, // ✅ Change from serviceTitle to serviceId
//     required this.date,
//     required this.time,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Book Service"),
//         centerTitle: true,
//         backgroundColor: Colors.teal,
//         foregroundColor: Colors.white,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Service ID: $serviceId", // ✅ Show service ID instead of title
//               style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               "Date: $date",
//               style: const TextStyle(fontSize: 16, color: Colors.black),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               "Time: $time",
//               style: const TextStyle(fontSize: 16, color: Colors.black),
//             ),
//             const SizedBox(height: 16),
//             BlocConsumer<BookingBloc, BookingState>(
//               listener: (context, state) {
//                 if (state is BookingSuccess) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text(state.message)),
//                   );
//                 } else if (state is BookingFailure) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text(state.error)),
//                   );
//                 }
//               },
//               builder: (context, state) {
//                 if (state is BookingLoading) {
//                   return const Center(child: CircularProgressIndicator());
//                 }

//                 return SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       context.read<BookingBloc>().add(
//                             CreateBookingEvent({
//                               'userId': userId, // ✅ Backend requires userId
//                               'serviceId':
//                                   serviceId, // ✅ Backend requires serviceId
//                               'date': date,
//                               'time': time,
//                             }),
//                           );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.teal, // Teal-colored button
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       padding: const EdgeInsets.symmetric(vertical: 12),
//                     ),
//                     child: const Text("Confirm Booking",
//                         style: TextStyle(color: Colors.white)),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
