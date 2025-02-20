import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
import '../entity/service_entity.dart';
import '../repository/service_repository.dart';

class GetServiceByIdParams extends Equatable {
  final String serviceId;

  const GetServiceByIdParams({required this.serviceId});

  @override
  List<Object?> get props => [serviceId];
}

class GetServiceByIdUseCase
    implements UsecaseWithParams<ServiceEntity, GetServiceByIdParams> {
  final IServiceRepository serviceRepository;

  GetServiceByIdUseCase({required this.serviceRepository});

  @override
  Future<Either<Failure, ServiceEntity>> call(
      GetServiceByIdParams params) async {
    return await serviceRepository.getServiceById(params.serviceId);
  }
}
