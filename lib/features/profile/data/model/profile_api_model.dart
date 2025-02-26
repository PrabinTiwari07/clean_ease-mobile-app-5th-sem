import 'package:clean_ease/features/profile/domain/entity/profile_entity.dart';

class ProfileApiModel extends ProfileEntity {
  ProfileApiModel({
    required super.id,
    required super.fullname,
    required super.email,
    required super.phone,
    required super.image,
    required super.address,
  });

  factory ProfileApiModel.fromJson(Map<String, dynamic> json) {
    return ProfileApiModel(
      id: json["_id"] ?? "",
      fullname: json["fullname"] ?? "", // ✅ Match API response key
      email: json["email"] ?? "",
      phone: json["phone"] ?? "",
      image: json["image"] ?? "",
      address: json["address"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "fullname": fullname, // ✅ Match API key
      "email": email,
      "phone": phone,
      "image": image,
      "address": address,
    };
  }
}
