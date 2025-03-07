import 'package:clean_ease/features/booking/presentation/view/booking_history_view.dart';
import 'package:clean_ease/features/booking/presentation/view_model/booking_bloc.dart';
import 'package:clean_ease/features/booking/presentation/view_model/booking_event.dart';
import 'package:clean_ease/features/booking/presentation/view_model/booking_state.dart';
import 'package:clean_ease/features/service/domain/entity/service_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class BookingView extends StatefulWidget {
  final ServiceEntity service; // ✅ Full service details passed

  const BookingView({super.key, required this.service});

  @override
  _BookingViewState createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  final TextEditingController pickupController = TextEditingController();
  final TextEditingController dropOffController = TextEditingController();

  /// ✅ Function to pick date & time
  void _pickDateTime(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
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

  /// ✅ Function to get full image URL
  String getFullImageUrl(String imagePath) {
    // const String baseUrl = "http://10.0.2.2:3000";
    const String baseUrl = "http://192.168.1.71:3000";

    return imagePath.startsWith("http") ? imagePath : "$baseUrl$imagePath";
  }

  /// ✅ Function to confirm booking
  void _confirmBooking(BuildContext context) {
    if (selectedDate == null || selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a date and time!")),
      );
      return;
    }

    if (pickupController.text.isEmpty || dropOffController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Please enter pickup and drop-off locations!")),
      );
      return;
    }

    final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate!);
    final formattedTime = selectedTime!.format(context);

    context.read<BookingBloc>().add(
          BookServiceEvent(
            serviceId: widget.service.serviceId,
            date: formattedDate,
            time: formattedTime,
            pickupLocation: pickupController.text,
            dropOffLocation: dropOffController.text,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context)
          .unfocus(), // ✅ Hides keyboard when tapping outside
      child: Scaffold(
        resizeToAvoidBottomInset: true, // ✅ Prevents overflow
        appBar: AppBar(
          title: const Text("Booking Page"),
          backgroundColor: Colors.teal, // ✅ Matching theme
          centerTitle: true,
          elevation: 2,
        ),
        body: BlocConsumer<BookingBloc, BookingState>(
          listener: (context, state) {
            if (state is BookingSuccess || state is BookingError) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("✅ Booking Confirmed Successfully!"),
                  backgroundColor: Colors.green, // ✅ Success toast
                ),
              );

              Future.delayed(const Duration(seconds: 1), () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BookingHistoryView()),
                );
              });
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// ✅ Service Card for Consistency
                    Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          /// ✅ Service Image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              getFullImageUrl(widget.service.image),
                              height: 180,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.image_not_supported,
                                      size: 100, color: Colors.grey),
                            ),
                          ),
                          const SizedBox(height: 10),

                          /// ✅ Service Details
                          Text(
                            widget.service.title,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "Category: ${widget.service.category}",
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Text(
                              widget.service.description,
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black87),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Price: \$${widget.service.price.toString()}",
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal),
                          ),
                        ],
                      ),
                    ),

                    /// ✅ Date & Time Picker
                    ElevatedButton(
                      onPressed: () => _pickDateTime(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 24),
                      ),
                      child: Text(
                        selectedDate == null || selectedTime == null
                            ? "Select Date & Time"
                            : "Selected: ${DateFormat('yyyy-MM-dd').format(selectedDate!)} at ${selectedTime!.format(context)}",
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// ✅ Pickup & Drop-off Fields
                    TextField(
                      controller: pickupController,
                      decoration: InputDecoration(
                        labelText: "Pickup Location",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: dropOffController,
                      decoration: InputDecoration(
                        labelText: "Drop-Off Location",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// ✅ Confirm Booking Button
                    ElevatedButton(
                      onPressed: () => _confirmBooking(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 36),
                      ),
                      child: const Text("Confirm Booking",
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
