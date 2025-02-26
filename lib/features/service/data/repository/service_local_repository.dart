// import 'package:clean_ease/core/error/failure.dart';
// import 'package:clean_ease/features/service/data/data_source/local_data_source/service_local_data_source.dart';
// import 'package:clean_ease/features/service/domain/entity/service_entity.dart';
// import 'package:clean_ease/features/service/domain/repository/service_repository.dart';
// import 'package:dartz/dartz.dart';

// class ServiceLocalRepository implements IServiceRepository {
//   final ServiceLocalDataSource serviceLocalDataSource;

//   ServiceLocalRepository({required this.serviceLocalDataSource});

//   @override
//   Future<Either<Failure, List<ServiceEntity>>> getServices() async {
//     try {
//       final services = await serviceLocalDataSource.getServices();
//       return Right(services);
//     } catch (e) {
//       return Left(LocalDatabaseFailure(message: e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, ServiceEntity>> getServiceById(String id) async {
//     try {
//       final service = await serviceLocalDataSource.getServiceById(id);
//       return Right(service);
//     } catch (e) {
//       return Left(LocalDatabaseFailure(message: e.toString()));
//     }
//   }
// }
