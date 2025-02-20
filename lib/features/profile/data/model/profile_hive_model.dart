import 'package:clean_ease/features/profile/domain/entity/profile_entity.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:uuid/uuid.dart';

part 'profile_hive_model.g.dart';

@HiveType(typeId: 4)
class ProfileHiveModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String address;

  @HiveField(3)
  String phone;

  @HiveField(4)
  String image;

  ProfileHiveModel({
    String? id,
    // required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.image,
  }) : id = id ?? const Uuid().v4();

  ProfileHiveModel.initial()
      : id = '',
        name = '',
        address = '',
        phone = '',
        image = '';

  // From Entity
  factory ProfileHiveModel.fromEntity(ProfileEntity entity) {
    return ProfileHiveModel(
      id: entity.id,
      name: entity.name,
      address: entity.address,
      phone: entity.phone,
      image: entity.image,
    );
  }

  // To Entity
  ProfileEntity toEntity() {
    return ProfileEntity(
      id: id,
      name: name,
      address: address,
      phone: phone,
      image: image,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        address,
        phone,
      ];
}
