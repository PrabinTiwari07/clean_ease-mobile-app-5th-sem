import 'package:clean_ease/features/service/data/data_source/remote_data_source/service_remote_data_source.dart';
import 'package:clean_ease/features/service/domain/entity/service_entity.dart';
import 'package:clean_ease/features/service/domain/repository/service_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

class ServiceRemoteRepository implements IServiceRepository {
  final ServiceRemoteDataSource serviceRemoteDataSource;

  ServiceRemoteRepository({required this.serviceRemoteDataSource});

  @override
  Future<Either<Failure, List<ServiceEntity>>> getServices() async {
    try {
      final services = await serviceRemoteDataSource.getServices();
      return Right(services);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ServiceEntity>> getServiceById(String id) async {
    try {
      final service = await serviceRemoteDataSource.getServiceById(id);
      return Right(service);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
