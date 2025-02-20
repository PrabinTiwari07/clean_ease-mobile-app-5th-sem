class ProfileEntity {
  final String id;
  final String name;
  final String address;
  final String phone;
  final String image;

  ProfileEntity({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.image,
  });
  // Add this method to fix the error
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'phone': phone,
      'image': image,
    };
  }
}
