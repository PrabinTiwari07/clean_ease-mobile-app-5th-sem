import 'package:clean_ease/app/shared_prefs/token_shared_prefs.dart';
import 'package:clean_ease/features/profile/data/model/profile_api_model.dart';
import 'package:dio/dio.dart';

class ProfileRemoteDataSource {
  final Dio dio;
  final TokenSharedPrefs tokenSharedPrefs;

  ProfileRemoteDataSource({required this.dio, required this.tokenSharedPrefs});

  Future<ProfileApiModel> getProfile() async {
    try {
      final token = await tokenSharedPrefs.getToken();
      final response = await dio.get(
        'http://10.0.2.2:3000/api/user/profile',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        return ProfileApiModel.fromJson(response.data);
      } else {
        throw Exception("Failed to fetch profile");
      }
    } catch (e) {
      throw Exception("Error fetching profile: $e");
    }
  }
}
