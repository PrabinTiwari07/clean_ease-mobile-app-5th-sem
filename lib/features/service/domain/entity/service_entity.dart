import 'package:equatable/equatable.dart';

class ServiceEntity extends Equatable {
  final String? serviceId; // ID might be optional
  final String name;
  final String type; // Single, Double, Suite
  final double price;
  final String description;
  final bool available;
  final List<String> images; // List of image URLs

  const ServiceEntity({
    this.serviceId,
    required this.name,
    required this.type,
    required this.price,
    required this.description,
    this.available = true,
    this.images = const [],
  });

  const ServiceEntity.empty()
      : serviceId = '_empty.serviceId',
        name = '_empty.name',
        type = '_empty.type',
        price = 0.0,
        description = '_empty.description',
        available = false,
        images = const [];

  @override
  List<Object?> get props => [
        serviceId,
        name,
        type,
        price,
        description,
        available,
        images,
      ];
}
