import 'package:clean_ease/features/profile/domain/entity/profile_entity.dart';

abstract class ProfileRepository {
  Future<ProfileEntity> getUserProfile();

  // getUserProfile() {}
}
