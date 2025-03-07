import 'package:equatable/equatable.dart';

import '../../domain/entity/price_entity.dart';

abstract class PriceState extends Equatable {
  @override
  List<Object> get props => [];
}

class PriceLoading extends PriceState {}

class PriceError extends PriceState {
  final String message;

  PriceError({required this.message});

  @override
  List<Object> get props => [message];
}

class PricesLoaded extends PriceState {
  final List<PriceEntity> prices;

  PricesLoaded({required this.prices});

  @override
  List<Object> get props => [prices];
}
