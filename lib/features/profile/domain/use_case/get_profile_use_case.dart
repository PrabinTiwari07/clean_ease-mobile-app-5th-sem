import 'package:clean_ease/features/profile/domain/entity/profile_entity.dart';
import 'package:clean_ease/features/profile/domain/repository/profile_repository.dart';

class GetProfileUseCase {
  final ProfileRepository repository;

  GetProfileUseCase(this.repository);

  Future<ProfileEntity> call() async {
    return await repository
        .getUserProfile(); // ✅ Now correctly returns ProfileEntity
  }
}
