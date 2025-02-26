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
    String imageUrl = json["image"] ?? "";

    // ✅ Replace 'localhost' with '10.0.2.2' for Android Emulator
    if (!imageUrl.startsWith("http")) {
      imageUrl = "http://10.0.2.2:3000$imageUrl"; // Append base URL
    }
    return ProfileApiModel(
      id: json["_id"] ?? "",
      fullname: json["fullname"] ?? "", // ✅ Match API response key
      email: json["email"] ?? "",
      phone: json["phone"] ?? "",
      // image: json["image"] ?? "",
      image: imageUrl, // ✅ Updated image URL

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
