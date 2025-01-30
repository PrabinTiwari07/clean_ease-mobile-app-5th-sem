import 'dart:io';

import 'package:clean_ease/features/auth/data/model/auth_hive_model.dart';
import 'package:clean_ease/features/auth/domain/entity/auth_entity.dart';

import '../../../../../core/network/hive_service.dart';
import '../auth_data_source.dart';

class AuthLocalDataSource implements IAuthDataSource {
  final HiveService _hiveService;

  AuthLocalDataSource(this._hiveService);

  @override
  Future<AuthEntity> getCurrentUser() {
    return Future.value(const AuthEntity(
      id: "1",
      fullName: "",
      phoneNo: "",
      address: "",
      email: "",
      password: "",
      // isAdmin: false,
    ));
  }

  @override
  Future<String> loginStudent(String email, String password) async {
    try {
      final user = await _hiveService.login(email, password);
      if (user != null) {
        return Future.value("Success");
      } else {
        return Future.error("Invalid credentials");
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<void> registerStudent(AuthEntity user) async {
    try {
      // Convert AuthEntity to UserHiveModel
      final userHiveModel = UserHiveModel(
        id: user.id,
        fullName: user.fullName,
        phoneNo: user.phoneNo,
        address: user.address,
        email: user.email,
        password: user.password,
        // isAdmin: user.isAdmin,
      );

      await _hiveService.addUser(userHiveModel);
      return Future.value();
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<String> uploadProfilePicture(File file) {
    // TODO: implement uploadProfilePicture
    throw UnimplementedError();
  }

  // @override
  // Future<String> uploadProfilePicture(File file) {
  //   throw UnimplementedError();
  // }
}
