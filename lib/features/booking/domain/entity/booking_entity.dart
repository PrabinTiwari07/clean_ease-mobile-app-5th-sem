import 'package:clean_ease/features/service/domain/entity/service_entity.dart';

class BookingEntity {
  final String id;
  final ServiceEntity service; // ✅ Full service details
  final String userId;
  final String date;
  final String time;
  final String pickupLocation;
  final String dropOffLocation;
  final String status;

  BookingEntity({
    required this.id,
    required this.service,
    required this.userId,
    required this.date,
    required this.time,
    required this.pickupLocation,
    required this.dropOffLocation,
    required this.status,
  });

  factory BookingEntity.fromJson(Map<String, dynamic> json) {
    try {
      return BookingEntity(
        id: json['_id']?.toString() ?? '',
        service: json['serviceId'] != null
            ? ServiceEntity(
                serviceId: json['serviceId']['_id']?.toString() ?? '',
                title: json['serviceId']['title']?.toString() ?? 'Unknown',
                category: json['serviceId']['category']?.toString() ??
                    'Uncategorized',
                price: (json['serviceId']['price'] ?? 0).toDouble(),
                description: json['serviceId']['description']?.toString() ?? '',
                image: json['serviceId']['image']?.toString() ?? '',
                createdAt: json['serviceId']['createdAt'] != null
                    ? DateTime.parse(json['serviceId']['createdAt'])
                    : DateTime.now(),
                updatedAt: json['serviceId']['updatedAt'] != null
                    ? DateTime.parse(json['serviceId']['updatedAt'])
                    : DateTime.now(),
              )
            : throw Exception("Invalid Service Data"),
        // ServiceEntity(
        //     serviceId: '',
        //     title: 'Unknown',
        //     category: 'Uncategorized',
        //     price: 0.0,
        //     description: '',
        //     image: '',
        //     createdAt: DateTime.now(),
        //     updatedAt: DateTime.now(),
        //   ),
        userId: json['userId']?.toString() ?? '',
        date: json['date']?.toString() ?? '',
        time: json['time']?.toString() ?? '',
        pickupLocation: json["pickupLocation"]?.toString() ?? "Not Provided",
        dropOffLocation: json["dropOffLocation"]?.toString() ?? "Not Provided",
        status: json['status']?.toString() ?? 'pending',
      );
    } catch (error) {
      print("❌ Error parsing booking JSON: $error");
      throw Exception("Invalid booking response format");
    }
  }
}
