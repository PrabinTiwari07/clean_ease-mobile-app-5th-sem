import 'dart:convert';

import 'package:clean_ease/app/constants/api_endpoints.dart';
import 'package:http/http.dart' as http;

class BookingDataSource {
  final String baseUrl;
  final String authToken;

  BookingDataSource({required this.baseUrl, required this.authToken});

  Future<void> createBooking(
      String userId, String serviceId, String date, String time) async {
    final response = await http.post(
      Uri.parse('$baseUrl${ApiEndpoints.bookService}'), // ✅ Correct API path
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken', // ✅ Ensure token is passed
      },
      body: jsonEncode({
        'userId': userId, // ✅ Send correct request body
        // 'serviceId': serviceId,
        'serviceId': serviceId,
        // 'serviceId': service._id,

        'date': date,
        'time': time,
      }),
    );

    if (response.statusCode == 201) {
      return;
    } else {
      throw Exception('Failed to book service: ${response.body}');
    }
  }
}
