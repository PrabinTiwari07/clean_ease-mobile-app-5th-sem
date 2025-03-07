import 'package:dartz/dartz.dart';

import '../../domain/entity/price_entity.dart';

class PriceApiModel extends PriceEntity {
  PriceApiModel({
    required super.id,
    required super.title,
    required super.image,
    required super.price,
  });

  factory PriceApiModel.fromJson(Map<String, dynamic> json) {
    return PriceApiModel(
      id: json["_id"],
      title: json["title"],
      image: json["image"] ?? "",
      price: (json["price"] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "title": title,
      "image": image,
      "price": price,
    };
  }
}
