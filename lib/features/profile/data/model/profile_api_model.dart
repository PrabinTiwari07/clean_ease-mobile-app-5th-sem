import 'package:clean_ease/features/profile/domain/entity/profile_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_api_model.g.dart';

@JsonSerializable()
class ProfileApiModel extends Equatable {
  final String id;
  final String name;
  final String address;
  final String phone;
  final String image;

  const ProfileApiModel({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.image,
  });

  const ProfileApiModel.empty()
      : id = '',
        name = '',
        address = '',
        phone = '',
        image = '';

  // From JSON
  factory ProfileApiModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileApiModelFromJson(json);

  // To JSON
  Map<String, dynamic> toJson() => _$ProfileApiModelToJson(this);

  // factory ProfileApiModel.fromJson(Map<String, dynamic> json) {
  //   return ProfileApiModel(
  //     id: json['id'],
  //     name: json['name'],
  //     address: json['address'],
  //     phone: json['phone'],
  //     image: json['image'],
  //   );
  // }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'name': name,
  //     'address': address,
  //     'phone': phone,
  //     'image': image,
  //   };
  // }
// }

// Convert ServiceApiModel to ServiceEntity
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
        image,
      ];
}
