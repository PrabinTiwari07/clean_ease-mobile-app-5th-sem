import 'package:equatable/equatable.dart';

import '../../domain/entity/service_entity.dart';

abstract class ServiceState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ServiceInitial extends ServiceState {}

class ServiceLoading extends ServiceState {}

class ServicesLoaded extends ServiceState {
  final List<ServiceEntity> services;

  ServicesLoaded({required this.services});

  @override
  List<Object?> get props => [services];
}

class ServiceLoaded extends ServiceState {
  final ServiceEntity service;

  ServiceLoaded({required this.service});

  @override
  List<Object?> get props => [service];
}

class ServiceError extends ServiceState {
  final String message;

  ServiceError({required this.message});

  @override
  List<Object?> get props => [message];
}
