import 'package:clean_ease/features/service/domain/entity/service_entity.dart';
import 'package:clean_ease/features/service/presentation/view_model/service_bloc.dart';
import 'package:clean_ease/features/service/presentation/view_model/service_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PriceBloc extends Cubit<List<ServiceEntity>> {
  final ServiceBloc serviceBloc;

  PriceBloc({required this.serviceBloc}) : super([]) {
    if (serviceBloc.state is ServicesLoaded) {
      _updateServices((serviceBloc.state as ServicesLoaded).services);
    } else {
      print("🔴 ServiceBloc is NOT in ServicesLoaded state.");
    }

    serviceBloc.stream.listen((state) {
      if (state is ServicesLoaded) {
        _updateServices(state.services);
      }
    });
  }

  void _updateServices(List<ServiceEntity> services) {
    // ✅ No filtering, just emit all services
    emit(services);
  }
}
