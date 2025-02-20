import 'package:equatable/equatable.dart';

import '../../domain/entity/profile_entity.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadProfile extends ProfileEvent {}

class UpdateProfile extends ProfileEvent {
  final ProfileEntity profile;
  UpdateProfile(this.profile);

  @override
  List<Object?> get props => [profile];
}

class ChangePassword extends ProfileEvent {
  final String oldPassword;
  final String newPassword;
  ChangePassword(this.oldPassword, this.newPassword);

  @override
  List<Object?> get props => [oldPassword, newPassword];
}

class Logout extends ProfileEvent {}
