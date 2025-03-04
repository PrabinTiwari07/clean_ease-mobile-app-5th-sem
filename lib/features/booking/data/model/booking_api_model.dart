class BookingApiModel {
  final String id;
  final String userId;
  final String serviceId;
  final String status;
  final DateTime createdAt;

  BookingApiModel({
    required this.id,
    required this.userId,
    required this.serviceId,
    required this.status,
    required this.createdAt,
  });

  factory BookingApiModel.fromJson(Map<String, dynamic> json) {
    return BookingApiModel(
      id: json['_id'],
      userId: json['userId'],
      serviceId: json['serviceId'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'serviceId': serviceId,
      'status': status,
    };
  }
}
