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

      final response = await dio.post(
        "${ApiEndpoints.baseUrl}books",
        data: bookingData,
        options: Options(headers: {"Authorization": "Bearer $authToken"}),
      );

      return BookingEntity.fromJson(response.data["booking"]);
    } catch (error) {
      throw Exception("Failed to book service");
    }
  }
}
