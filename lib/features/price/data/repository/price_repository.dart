import 'package:clean_ease/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../domain/entity/price_entity.dart';
import '../data_source/price_remote_data_source.dart';

class PriceRepository {
  final PriceRemoteDataSource remoteDataSource;

  PriceRepository({required this.remoteDataSource});

  Future<Either<Failure, List<PriceEntity>>> getPrices() async {
    try {
      final prices = await remoteDataSource.fetchPrices();
      return Right(prices); // ✅ Success case
    } on DioException catch (e) {
      return Left(ApiFailure(
        statusCode: e.response?.statusCode,
        message: "API Error: ${e.message}",
      ));
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: "Unexpected Error: $e"));
    }
  }
}
