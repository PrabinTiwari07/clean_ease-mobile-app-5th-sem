import 'package:clean_ease/features/service/domain/entity/service_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'service_api_model.g.dart';

@JsonSerializable()
class ServiceApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? serviceId;
  final String name;
  final String type;
  final double price;
  final String description;
  final bool available;
  final List<String> images;

  const ServiceApiModel({
    this.serviceId,
    required this.name,
    required this.type,
    required this.price,
    required this.description,
    required this.available,
    required this.images,
  });

  const ServiceApiModel.empty()
      : serviceId = '',
        name = '',
        type = '',
        price = 0.0,
        description = '',
        available = false,
        images = const [];

  // From JSON
  factory ServiceApiModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceApiModelFromJson(json);

  // To JSON
  Map<String, dynamic> toJson() => _$ServiceApiModelToJson(this);

  // Convert ServiceApiModel to ServiceEntity
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
