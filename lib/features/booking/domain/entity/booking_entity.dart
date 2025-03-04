class BookingEntity {
  final String id;
  final String serviceId;
  final String userId;
  final String date;
  final String time;
  final String pickupLocation;
  final String dropOffLocation;
  final String status;

  BookingEntity({
    required this.id,
    required this.serviceId,
    required this.userId,
    required this.date,
    required this.time,
    required this.pickupLocation,
    required this.dropOffLocation,
    required this.status,
  });

  factory BookingEntity.fromJson(Map<String, dynamic> json) {
    return BookingEntity(
      id: json['_id'],
      serviceId: json['serviceId'],
      userId: json['userId'],
      date: json['date'],
      time: json['time'],
      pickupLocation: json['pickupLocation'],
      dropOffLocation: json['dropOffLocation'],
      status: json['status'],
    );
  }
}
