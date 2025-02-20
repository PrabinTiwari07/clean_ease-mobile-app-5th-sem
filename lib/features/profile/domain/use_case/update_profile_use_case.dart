import 'package:clean_ease/features/profile/data/repository/profile_repository.dart';

import '../entity/profile_entity.dart';

class UpdateProfileUseCase {
  final ProfileRepository repository;

  UpdateProfileUseCase(this.repository);

  Future<void> call(ProfileEntity profile) async {
    return await repository.updateProfile(profile);
  }
}
