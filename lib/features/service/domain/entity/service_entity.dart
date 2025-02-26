// import 'package:equatable/equatable.dart';

// class ServiceEntity extends Equatable {
//   final String? serviceId; // ID might be optional
//   final String name;
//   final String type; // Single, Double, Suite
//   final double price;
//   final String description;
//   final bool available;
//   final List<String> images; // List of image URLs

//   const ServiceEntity({
//     this.serviceId,
//     required this.name,
//     required this.type,
//     required this.price,
//     required this.description,
//     this.available = true,
//     this.images = const [],
//   });

//   const ServiceEntity.empty()
//       : serviceId = '_empty.serviceId',
//         name = '_empty.name',
//         type = '_empty.type',
//         price = 0.0,
//         description = '_empty.description',
//         available = false,
//         images = const [];

//   @override
//   List<Object?> get props => [
//         serviceId,
//         name,
//         type,
//         price,
//         description,
//         available,
//         images,
//       ];
// }

import 'package:equatable/equatable.dart';

class ServiceEntity extends Equatable {
  final String serviceId;
  final String title;
  final String category;
  final double price;
  final String description;
  final String image;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ServiceEntity({
    required this.serviceId,
    required this.title,
    required this.category,
    required this.price,
    required this.description,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Factory constructor for empty state (fixes the invalid constant issue)
  factory ServiceEntity.empty() {
    return ServiceEntity(
      serviceId: '',
      title: '',
      category: '',
      price: 0.0,
      description: '',
      image: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  @override
  List<Object?> get props => [
        serviceId,
        title,
        category,
        price,
        description,
        image,
        createdAt,
        updatedAt,
      ];
}
