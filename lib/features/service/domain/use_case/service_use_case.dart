import 'package:clean_ease/features/service/domain/entity/service_entity.dart';
import 'package:clean_ease/features/service/domain/repository/service_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';

class GetServicesUseCase implements UsecaseWithoutParams<List<ServiceEntity>> {
  final IServiceRepository serviceRepository;

  GetServicesUseCase({required this.serviceRepository});

  @override
  Future<Either<Failure, List<ServiceEntity>>> call() async {
    return await serviceRepository.getServices();
  }
}
