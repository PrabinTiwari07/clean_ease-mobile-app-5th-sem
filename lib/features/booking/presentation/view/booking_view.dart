import 'package:flutter/material.dart';

class BookingView extends StatelessWidget {
  final String serviceTitle;
  final double servicePrice;

  const BookingView({
    super.key,
    required this.serviceTitle,
    required this.servicePrice,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Booking Page")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Booking for: $serviceTitle",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "Price: \$${servicePrice.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 18, color: Colors.teal),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: "Enter your details",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement booking logic
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Booking Confirmed!")),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal, // Teal-colored button
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text("Confirm Booking",
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
