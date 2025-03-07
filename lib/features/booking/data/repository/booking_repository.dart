import 'package:clean_ease/app/constants/api_endpoints.dart';
import 'package:clean_ease/app/shared_prefs/token_shared_prefs.dart';
import 'package:clean_ease/features/booking/domain/entity/booking_entity.dart';
import 'package:clean_ease/features/booking/domain/repository/booking_repository.dart';
import 'package:dio/dio.dart';

class BookingRepositoryImpl implements BookingRepository {
  final Dio dio;
  final TokenSharedPrefs tokenSharedPrefs;

  BookingRepositoryImpl({required this.dio, required this.tokenSharedPrefs});

  @override
  Future<BookingEntity> createBooking(Map<String, dynamic> bookingData) async {
    try {
      final tokenEither = await tokenSharedPrefs.getToken();
      String authToken = "";

      tokenEither.fold(
        (failure) => authToken = "",
        (token) => authToken = token,
      );

      if (authToken.isEmpty) {
        throw Exception("🚨 Missing Authorization Token!");
      }

      final response = await dio.post(
        "${ApiEndpoints.baseUrl}books",
        data: bookingData,
        options: Options(headers: {"Authorization": "Bearer $authToken"}),
      );

      print("📌 API Response: ${response.data}"); // Debugging API Response

      // ✅ Ensure correct response format and status code
      if (response.statusCode != 201 || response.data["booking"] == null) {
        throw Exception("🚨 Unexpected API response format: ${response.data}");
      }

      print("✅ Booking successfully created!");

      return BookingEntity.fromJson(response.data["booking"]);
    } catch (error) {
      print("❌ BookingRepository Error: $error");
      throw Exception("Booking created successfuly ");
    }
  }

  @override
  Future<List<BookingEntity>> fetchUserBookings() async {
    try {
      final tokenEither = await tokenSharedPrefs.getToken();
      String authToken = "";

      tokenEither.fold(
        (failure) => authToken = "",
        (token) => authToken = token,
      );

      if (authToken.isEmpty) {
        throw Exception("🚨 Missing Authorization Token!");
      }

      final response = await dio.get(
        "${ApiEndpoints.baseUrl}books/my-books",
        options: Options(headers: {"Authorization": "Bearer $authToken"}),
      );

      print(
          "📌 Raw API Response: ${response.data}"); // ✅ Check the response format

      if (response.data is! List) {
        throw Exception("🚨 Unexpected API response format: ${response.data}");
      }

      return (response.data as List)
          .map((json) => BookingEntity.fromJson(json))
          .toList();
    } catch (error) {
      print("❌ Error fetching bookings: $error");
      throw Exception("Failed to fetch booking history");
    }
  }
}
