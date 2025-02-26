import 'package:equatable/equatable.dart';

abstract class ServiceEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetServicesEvent extends ServiceEvent {}

class GetServiceByIdEvent extends ServiceEvent {
  final String serviceId;

  GetServiceByIdEvent({required this.serviceId});

  @override
  List<Object?> get props => [serviceId];
}
