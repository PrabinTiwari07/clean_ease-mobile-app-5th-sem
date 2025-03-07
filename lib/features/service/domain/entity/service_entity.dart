// import 'package:equatable/equatable.dart';

// class ServiceEntity extends Equatable {
//   final String serviceId;
//   final String title;
//   final String category;
//   final double price;
//   final String description;
//   final String image;
//   final DateTime createdAt;
//   final DateTime updatedAt;

//   const ServiceEntity({
//     required this.serviceId,
//     required this.title,
//     required this.category,
//     required this.price,
//     required this.description,
//     required this.image,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   /// Factory constructor for empty state (fixes the invalid constant issue)
//   factory ServiceEntity.empty() {
//     return ServiceEntity(
//       serviceId: '',
//       title: '',
//       category: '',
//       price: 0.0,
//       description: '',
//       image: '',
//       createdAt: DateTime.now(),
//       updatedAt: DateTime.now(),
//     );
//   }

//   @override
//   List<Object?> get props => [
//         serviceId,
//         title,
//         category,
//         price,
//         description,
//         image,
//         createdAt,
//         updatedAt,
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

  factory ServiceEntity.fromJson(Map<String, dynamic> json) {
    return ServiceEntity(
      serviceId: json['_id'],
      title: json['title'] ?? '',
      category: json['category'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
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
