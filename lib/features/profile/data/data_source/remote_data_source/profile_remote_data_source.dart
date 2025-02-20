// // import 'package:clean_ease/app/constants/api_endpoints.dart';
// // import 'package:clean_ease/features/profile/data/model/profile_api_model.dart';
// // import 'package:dio/dio.dart';

// // class ProfileRemoteDataSource {
// //   final Dio dio;

// //   ProfileRemoteDataSource({required this.dio});

// //   Future<ProfileModel> getProfile() async {
// //     final response = await dio.get(ApiEndpoints.getUserProfile);
// //     return ProfileModel.fromJson(response.data);
// //   }

// //   Future<void> updateProfile(Map<String, dynamic> data) async {
// //     await dio.post(ApiEndpoints.updateUserProfile, data: data);
// //   }

// //   Future<void> changePassword(String oldPassword, String newPassword) async {
// //     await dio.post(ApiEndpoints.changePassword, data: {
// //       'old_password': oldPassword,
// //       'new_password': newPassword,
// //       // 'new_password': newPassword,
// //     });
// //   }

// //   Future<void> logout() async {
// //     await dio.post(ApiEndpoints.logout);
// //   }
// // }

// import 'package:clean_ease/app/constants/api_endpoints.dart';
// import 'package:dio/dio.dart';
// import '../../model/profile_api_model.dart';
// import '../../../app/constants/api_endpoints.dart';

// class ProfileRemoteDataSource {
//   final Dio dio;

//   ProfileRemoteDataSource({required this.dio});

//   Future<ProfileApiModel> getProfile() async {
//     final response = await dio.get(ApiEndpoints.getUserProfile);
//     return ProfileApiModel.fromJson(response.data);
//   }

//   Future<void> updateProfile(Map<String, dynamic> data) async {
//     await dio.post(ApiEndpoints.updateUserProfile, data: data);
//   }

//   Future<void> changePassword(String oldPassword, String newPassword) async {
//     await dio.post(ApiEndpoints.changePassword, data: {
//       'old_password': oldPassword,
//       'new_password': newPassword,
//     });
//   }

//   Future<void> logout() async {
//     await dio.post(ApiEndpoints.logout);
//   }
// }

import 'package:clean_ease/app/constants/api_endpoints.dart';
import 'package:dio/dio.dart';

import '../../model/profile_api_model.dart';

class ProfileRemoteDataSource {
  final Dio dio;

  ProfileRemoteDataSource({required this.dio});

  Future<ProfileApiModel> getProfile() async {
    final response = await dio.get(ApiEndpoints.getUserProfile);
    return ProfileApiModel.fromJson(response.data);
  }

  Future<void> updateProfile(Map<String, dynamic> data) async {
    await dio.post(ApiEndpoints.updateUserProfile, data: data);
  }

  Future<void> changePassword(String oldPassword, String newPassword) async {
    await dio.post(ApiEndpoints.changePassword, data: {
      'old_password': oldPassword,
      'new_password': newPassword,
    });
  }

  Future<void> logout() async {
    await dio.post(ApiEndpoints.logout);
  }
}
