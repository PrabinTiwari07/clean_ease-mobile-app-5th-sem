import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? id;
  final String fullName;
  final String phoneNo;
  final String address;
  final String email;
  final String password;
  // final bool isAdmin;

  const AuthEntity({
    this.id,
    required this.fullName,
    required this.phoneNo,
    required this.address,
    required this.email,
    required this.password,
    // this.isAdmin = false,
  });

  @override
  List<Object?> get props => [id, fullName, phoneNo, address, email, password];
}
