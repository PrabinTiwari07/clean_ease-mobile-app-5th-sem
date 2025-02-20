import 'package:clean_ease/features/profile/data/data_source/local_data_source/profile_local_data_source.dart';
import 'package:clean_ease/features/profile/data/data_source/remote_data_source/profile_remote_data_source.dart';
import 'package:clean_ease/features/profile/data/model/profile_hive_model.dart';
import 'package:clean_ease/features/profile/data/repository/profile_repository.dart';

import '../../domain/entity/profile_entity.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  final ProfileLocalDataSource localDataSource;

  ProfileRepositoryImpl(
      {required this.remoteDataSource, required this.localDataSource});

  @override
  Future<ProfileEntity> getProfile() async {
    try {
      final profileModel = await remoteDataSource.getProfile();
      final profileEntity = ProfileEntity(
        id: profileModel.id,
        name: profileModel.name,
        address: profileModel.address,
        phone: profileModel.phone,
        image: profileModel.image,
      );

      localDataSource.saveProfile(ProfileHiveModel(
        id: profileModel.id,
        name: profileModel.name,
        address: profileModel.address,
        phone: profileModel.phone,
        image: profileModel.image,
      ));

      return profileEntity;
    } catch (e) {
      final localProfile = localDataSource.getProfile();
      if (localProfile != null) {
        return ProfileEntity(
          id: localProfile.id,
          name: localProfile.name,
          address: localProfile.address,
          phone: localProfile.phone,
          image: localProfile.image,
        );
      } else {
        throw Exception("Failed to fetch profile.");
      }
    }
  }

  @override
  Future<void> updateProfile(ProfileEntity profile) async {
    await remoteDataSource.updateProfile(profile.toJson());
  }

  @override
  Future<void> changePassword(String oldPassword, String newPassword) async {
    await remoteDataSource.changePassword(oldPassword, newPassword);
  }

  @override
  Future<void> logout() async {
    await remoteDataSource.logout();
    await localDataSource.clearProfile();
  }
}
