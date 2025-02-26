import 'package:clean_ease/features/service/domain/entity/service_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

abstract interface class IServiceRepository {
  /// Fetch all available Services
  Future<Either<Failure, List<ServiceEntity>>> getServices();

  /// Fetch a specific Service by its ID
  Future<Either<Failure, ServiceEntity>> getServiceById(String id);
}
