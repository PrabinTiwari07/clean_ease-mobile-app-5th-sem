import 'package:clean_ease/features/service/domain/use_case/service_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failure.dart';
import '../../domain/use_case/get_service_by_id_usecase.dart';
import 'service_event.dart';
import 'service_state.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  final GetServicesUseCase getServicesUseCase;
  final GetServiceByIdUseCase getServiceByIdUseCase;

  ServiceBloc({
    required this.getServicesUseCase,
    required this.getServiceByIdUseCase,
  }) : super(ServiceInitial()) {
    on<GetServicesEvent>(_onGetServicesEvent);
    on<GetServiceByIdEvent>(_onGetServiceByIdEvent);
  }

  Future<void> _onGetServicesEvent(
      GetServicesEvent event, Emitter<ServiceState> emit) async {
    emit(ServiceLoading());
    final result = await getServicesUseCase();
    result.fold(
      (failure) => emit(ServiceError(message: _mapFailureToMessage(failure))),
      (services) => emit(ServicesLoaded(services: services)),
    );
  }

  Future<void> _onGetServiceByIdEvent(
      GetServiceByIdEvent event, Emitter<ServiceState> emit) async {
    emit(ServiceLoading());
    final result = await getServiceByIdUseCase(
        GetServiceByIdParams(serviceId: event.serviceId));
    result.fold(
      (failure) => emit(ServiceError(message: _mapFailureToMessage(failure))),
      (service) => emit(ServiceLoaded(service: service)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is LocalDatabaseFailure) {
      return "Failed to fetch data from local storage.";
    } else if (failure is ApiFailure) {
      return "Failed to fetch data from the server.";
    }
    return "Unexpected error occurred.";
  }
}
