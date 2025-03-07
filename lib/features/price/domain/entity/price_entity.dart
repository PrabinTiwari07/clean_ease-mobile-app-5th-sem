import 'package:equatable/equatable.dart';

class PriceEntity extends Equatable {
  final String id;
  final String title;
  final String image;
  final double price;

  const PriceEntity({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
  });

  @override
  List<Object?> get props => [id, title, image, price];
}
