import 'package:hive/hive.dart';

import '../../model/profile_hive_model.dart';

class ProfileLocalDataSource {
  final Box<ProfileHiveModel> profileBox;

  ProfileLocalDataSource({required this.profileBox});

  ProfileHiveModel? getProfile() {
    return profileBox.get('profile');
  }

  Future<void> saveProfile(ProfileHiveModel profile) async {
    await profileBox.put('profile', profile);
  }

  Future<void> clearProfile() async {
    await profileBox.delete('profile');
  }
}
