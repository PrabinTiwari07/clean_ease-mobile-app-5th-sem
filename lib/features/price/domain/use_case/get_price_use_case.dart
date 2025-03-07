import 'package:clean_ease/core/error/failure.dart';
import 'package:clean_ease/features/price/data/repository/price_repository.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entity/price_entity.dart';

class GetPricesUseCase {
  final PriceRepository priceRepository;

  GetPricesUseCase({required this.priceRepository});

  Future<Either<Failure, List<PriceEntity>>> call() async {
    return await priceRepository
        .getPrices(); // ✅ This already returns Either<Failure, List<PriceEntity>>
  }
}
