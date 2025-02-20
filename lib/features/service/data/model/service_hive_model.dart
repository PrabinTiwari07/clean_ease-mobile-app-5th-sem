import 'package:clean_ease/features/service/domain/entity/service_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:uuid/uuid.dart';

part 'service_hive_model.g.dart';

@HiveType(typeId: 2) // Replace 1 with your unique typeId for Hive
class ServiceHiveModel extends Equatable {
  @HiveField(0)
  final String? serviceId;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String type;
  @HiveField(3)
  final double price;
  @HiveField(4)
  final String description;
  @HiveField(6)
  final bool available;
  @HiveField(7)
  final List<String> images;

  ServiceHiveModel({
    String? serviceId,
    required this.name,
    required this.type,
    required this.price,
    required this.description,
    this.available = true,
    this.images = const [],
  }) : serviceId = serviceId ?? const Uuid().v4();

  const ServiceHiveModel.initial()
      : serviceId = '',
        name = '',
        type = '',
        price = 0.0,
        description = '',
        available = false,
        images = const [];

  // From Entity
  factory ServiceHiveModel.fromEntity(ServiceEntity entity) {
    return ServiceHiveModel(
      serviceId: entity.serviceId,
      name: entity.name,
      type: entity.type,
      price: entity.price,
      description: entity.description,
      available: entity.available,
      images: entity.images,
    );
  }

  // To Entity
  ServiceEntity toEntity() {
    return ServiceEntity(
      serviceId: serviceId,
      name: name,
      type: type,
      price: price,
      description: description,
      available: available,
      images: images,
    );
  }

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
