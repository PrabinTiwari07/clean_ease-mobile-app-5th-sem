// import 'package:clean_ease/app/constants/hive_table_constants.dart';
// import 'package:clean_ease/features/auth/domain/entity/auth_entity.dart';
// import 'package:equatable/equatable.dart';
// import 'package:hive/hive.dart';
// import 'package:uuid/uuid.dart';

// @HiveType(typeId: HiveTableConstant.studentTableId)
// class AuthHiveModel extends Equatable {
//   @HiveField(0)
//   final String? userId;
//   @HiveField(1)
//   final String fName;
//   @HiveField(2)
//   final String lName;
//   @HiveField(3)
//   final String? image;
//   @HiveField(4)
//   final String phone;
//   @HiveField(5)
//   final String username;
//   @HiveField(8)
//   final String password;

//   AuthHiveModel({
//     String? userId,
//     required this.fName,
//     required this.lName,
//     this.image,
//     required this.phone,
//     required this.username,
//     required this.password,
//   }) : userId = userId ?? const Uuid().v4();

//   // Initial Constructor
//   const AuthHiveModel.initial()
//       : userId = '',
//         fName = '',
//         lName = '',
//         image = '',
//         phone = '',
//         username = '',
//         password = '';

//   // From Entity
//   factory AuthHiveModel.fromEntity(AuthEntity entity) {
//     return AuthHiveModel(
//       userId: entity.userId,
//       fName: entity.fName,
//       lName: entity.lName,
//       image: entity.image,
//       phone: entity.phone,
//       username: entity.username,
//       password: entity.password,
//     );
//   }

//   // To Entity
//   AuthEntity toEntity() {
//     return AuthEntity(
//       userId: userId,
//       fName: fName,
//       lName: lName,
//       image: image,
//       phone: phone,
//       username: username,
//       password: password,
//     );
//   }

//   @override
//   List<Object?> get props => [userId, fName, lName, image, username, password];
// }
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import '../../../../app/constants/hive_table_constants.dart';

part 'auth_hive_model.g.dart';

@HiveType(
    typeId:
        HiveTableConstant.userTableId) // Replace 1 with the appropriate type ID
class UserHiveModel extends Equatable {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String password;
  // @HiveField(3)
  // final bool isAdmin;

  UserHiveModel({
    String? id,
    required this.email,
    required this.password,
    // this.isAdmin = false,
  }) : id = id ?? const Uuid().v4();

  // Initial Constructor
  const UserHiveModel.initial()
      : id = '',
        email = '',
        password = '';
  // isAdmin = false;

  // From Entity as JSOn
  factory UserHiveModel.fromJson(Map<String, dynamic> json) {
    return UserHiveModel(
      id: json['id'] as String?,
      email: json['email'] as String,
      password: json['password'] as String,
      // isAdmin: json['isAdmin'] as bool? ?? false,
    );
  }

  // To Enstity as JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'password': password,
      // 'isAdmin': isAdmin,
    };
  }

  @override
  List<Object?> get props => [id, email, password];
}
