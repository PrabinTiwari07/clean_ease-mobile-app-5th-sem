// import 'package:clean_ease/app/shared_prefs/token_shared_prefs.dart';
// import 'package:clean_ease/core/error/failure.dart';
// import 'package:clean_ease/features/auth/domain/entity/auth_entity.dart';
// import 'package:clean_ease/features/profile/data/data_source/remote_data_source/user_remote_data_source.dart';
// import 'package:clean_ease/features/profile/domain/repository/user_repository.dart';
// import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
// import 'package:dartz/dartz.dart';

// class UserRemoteRepositoryImpl implements UserRepository {
//   final UserRemoteDataSource userRemoteDataSource;
//   final TokenSharedPrefs tokenSharedPrefs;

//   UserRemoteRepositoryImpl(this.userRemoteDataSource, this.tokenSharedPrefs);

//   @override
//   Future<Either<Failure, AuthEntity>> getUserProfile() async {
//     try {
//       print("📡 Retrieving Token for User Profile...");
//       final tokenResult = await tokenSharedPrefs.getToken();

//       return tokenResult.fold(
//         (failure) {
//           print("❌ Failed to retrieve token: ${failure.message}");
//           return Left(failure);
//         },
//         (token) async {
//           if (token.isEmpty) {
//             print("❌ Token is empty");
//             return const Left(ApiFailure(message: "Token is empty"));
//           }

//           print("✅ Token to be sent: $token");

//           final decodedToken = JWT.decode(token);
//           print("✅ Decoded Token Payload: ${decodedToken.payload}");

//           final userId = decodedToken
//               .payload['id']; // Make sure 'id' is inside the payload

//           if (userId == null || userId is! String) {
//             print("❌ User ID is null or invalid");
//             return const Left(
//                 ApiFailure(message: "User ID not found in token"));
//           }

//           print("📤 Fetching Profile for User ID: $userId");

//           final userModel =
//               await userRemoteDataSource.getUserProfile(userId, token);
//           print("✅ Successfully Retrieved User Profile: ${userModel.toJson()}");

//           return Right(userModel.toEntity());
//         },
//       );
//     } catch (e) {
//       print("❌ Error in getUserProfile: $e");
//       return Left(ApiFailure(message: e.toString()));
//     }
//   }
// }
