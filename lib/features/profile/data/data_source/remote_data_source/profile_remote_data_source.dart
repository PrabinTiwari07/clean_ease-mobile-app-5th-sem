import 'dart:convert';

import 'package:clean_ease/app/constants/api_endpoints.dart';
import 'package:clean_ease/app/shared_prefs/token_shared_prefs.dart';
import 'package:clean_ease/core/error/failure.dart';
import 'package:clean_ease/features/profile/data/model/profile_api_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class ProfileRemoteDataSource {
  final Dio dio;
  final TokenSharedPrefs tokenSharedPrefs;

  ProfileRemoteDataSource({required this.dio, required this.tokenSharedPrefs});

  Future<ProfileApiModel> getUserProfile() async {
    try {
      // ✅ Extract token correctly
      final Either<Failure, String> tokenResult =
          await tokenSharedPrefs.getToken();
      final String token = tokenResult.fold(
        (failure) =>
            throw Exception("Token retrieval failed: ${failure.toString()}"),
        (token) => token,
      );

      if (token.trim().isEmpty) {
        throw Exception("No token found. Please log in again.");
      }

      // ✅ Decode JWT Token to Get `userId`
      final List<String> tokenParts = token.split(".");
      if (tokenParts.length != 3) throw Exception("Invalid token format");

      final Map<String, dynamic> payload =
          json.decode(utf8.decode(base64Url.decode(tokenParts[1])));
      final String? userId = payload["id"];

      if (userId == null || userId.isEmpty) {
        throw Exception("User ID not found in token");
      }

      // ✅ Ensure Correct API URL Format
      final String url =
          '${ApiEndpoints.baseUrl}${ApiEndpoints.getUserProfile(userId)}';
      print("🔎 Fetching User from: $url");

      // ✅ Make API Call
      final response = await dio.get(
        url,
        options: Options(
          headers: {"Authorization": "Bearer $token"},
        ),
      );

      if (response.statusCode == 200) {
        final jsonData = response.data;
        print("✅ API Response: $jsonData"); // Debug log

        // Check if image URL is valid
        String imageUrl = response.data["image"] ?? "";
        print("🔎 Extracted Image URL: $imageUrl");

        return ProfileApiModel.fromJson(jsonData);
      } else {
        throw Exception("Failed to fetch user: ${response.statusMessage}");
      }
    } catch (e) {
      print("❌ Error in getUserProfile: $e");
      throw Exception("Error fetching user: $e");
    }
  }
}
