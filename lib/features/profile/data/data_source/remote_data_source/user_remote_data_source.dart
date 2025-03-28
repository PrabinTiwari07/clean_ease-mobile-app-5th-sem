// import 'package:clean_ease/app/constants/api_endpoints.dart';
// import 'package:clean_ease/core/error/failure.dart';
// import 'package:clean_ease/features/auth/data/model/auth_api_model.dart';
// import 'package:dio/dio.dart';

// abstract class UserRemoteDataSource {
//   Future<AuthApiModel> getUserProfile(String userId, String token);
// }

// // class UserRemoteDataSourceImpl implements UserRemoteDataSource {
// //   final Dio dio; // ✅ Use Dio directly

// //   UserRemoteDataSourceImpl(this.dio);

// //   @override
// //   Future<AuthApiModel> getUserProfile(String userId, String token) async {
// //     try {
// //       final String url =
// //           "${ApiEndpoints.getuser}$userId"; // ✅ Use `ApiEndpoints.getuser`

// //       print("📡 Fetching User Profile from: $url");

// //       final response = await dio.get(
// //         url,
// //         options: Options(headers: {"Authorization": "Bearer $token"}),
// //       );

// //       print("✅ API Response: ${response.data}");

// //       if (response.statusCode == 200) {
// //         return AuthApiModel.fromJson(response.data);
// //       } else {
// //         throw ApiFailure(
// //             message:
// //                 "Failed to fetch user profile: ${response.data['message']}");
// //       }
// //     } catch (e) {
// //       print("❌ Error in getUserProfile: $e");
// //       throw ApiFailure(message: e.toString());
// //     }
// //   }
// // }

// class UserRemoteDataSourceImpl implements UserRemoteDataSource {
//   final Dio dio; // ✅ Inject Dio instead of ApiService

//   UserRemoteDataSourceImpl(this.dio);

//   @override
//   Future<AuthApiModel> getUserProfile(String userId, String token) async {
//     try {
//       final response = await dio.get(
//         ApiEndpoints.getuser + userId, // ✅ Use ApiEndpoints
//         options: Options(headers: {"Authorization": "Bearer $token"}),
//       );

//       if (response.statusCode == 200) {
//         final jsonData = response.data;
//         print("✅ API Response: $jsonData"); // Debug log

//         return AuthApiModel.fromJson({
//           "_id": jsonData["_id"] ?? "",
//           "fullname": jsonData["fullname"] ?? "Unknown",
//           "address": jsonData["address"] ?? "No Address",
//           "phoneno": jsonData["phone"] ?? "No Phone",
//           "image": jsonData["image"],
//           "email": jsonData["email"] ?? "No Email",
//           "password": jsonData["password"] ?? "",
//           "otp": jsonData["otp"],
//           "otpExpires": jsonData["otpExpires"],
//         });
//       } else {
//         throw const ApiFailure(message: "Failed to fetch user profile");
//       }
//     } catch (e) {
//       print("❌ Error in getUserProfile: $e");
//       throw ApiFailure(message: e.toString());
//     }
//   }
// }
