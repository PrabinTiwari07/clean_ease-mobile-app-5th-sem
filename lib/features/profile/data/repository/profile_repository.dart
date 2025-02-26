import 'package:clean_ease/features/profile/data/data_source/remote_data_source/profile_remote_data_source.dart';
import 'package:clean_ease/features/profile/data/model/profile_api_model.dart';
import 'package:clean_ease/features/profile/domain/entity/profile_entity.dart';
import 'package:clean_ease/features/profile/domain/repository/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ProfileEntity> getUserProfile() async {
    final ProfileApiModel profileApiModel =
        await remoteDataSource.getUserProfile();

    // ✅ Convert ProfileApiModel to ProfileEntity before returning
    return ProfileEntity(
      id: profileApiModel.id,
      fullname: profileApiModel.fullname,
      address: profileApiModel.address,
      email: profileApiModel.email,
      image: profileApiModel.image,
      phone: profileApiModel.phone,
    );
  }
}
