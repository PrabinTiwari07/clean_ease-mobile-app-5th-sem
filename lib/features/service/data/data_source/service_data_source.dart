import 'package:clean_ease/features/service/domain/entity/service_entity.dart';

abstract interface class IServiceDataSource {
  /// Fetch all available Services
  Future<List<ServiceEntity>> getServices();

  /// Fetch a Service by its ID
  Future<ServiceEntity> getServiceById(String id);
}
