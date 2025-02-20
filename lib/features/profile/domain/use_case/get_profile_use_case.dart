import 'package:clean_ease/features/profile/data/repository/profile_repository.dart';

import '../entity/profile_entity.dart';

class GetProfileUseCase {
  final ProfileRepository repository;

  GetProfileUseCase(this.repository);

  Future<ProfileEntity> call() async {
    return await repository.getProfile();
  }
}
