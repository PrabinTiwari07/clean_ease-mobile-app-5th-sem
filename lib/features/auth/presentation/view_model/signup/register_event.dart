import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterStudentEvent extends RegisterEvent {
  final BuildContext context;
  final String fullName;
  final String phoneNo;
  final String address;
  final String email;
  final String password;
  final String confirmPassword;

  const RegisterStudentEvent({
    required this.context,
    required this.fullName,
    required this.phoneNo,
    required this.address,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  @override
  List<Object> get props =>
      [fullName, phoneNo, address, email, password, confirmPassword];
}
