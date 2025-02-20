import 'package:clean_ease/features/profile/domain/entity/profile_entity.dart';

abstract class ProfileRepository {
  Future<ProfileEntity> getProfile();
  Future<void> updateProfile(ProfileEntity profile);
  Future<void> changePassword(String oldPassword, String newPassword);
  Future<void> logout();
}
