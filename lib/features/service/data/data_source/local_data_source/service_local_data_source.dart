// import 'package:clean_ease/core/network/hive_service.dart';
// import 'package:clean_ease/features/service/data/data_source/service_data_source.dart';
// import 'package:clean_ease/features/service/domain/entity/service_entity.dart';

// class ServiceLocalDataSource implements IServiceDataSource {
//   final HiveService hiveService;

//   ServiceLocalDataSource({required this.hiveService});

//   @override
//   Future<List<ServiceEntity>> getServices() async {
//     try {
//       final services =
//           await hiveService.getAllServices(); // Retrieve all services
//       return services
//           .map((service) => service.toEntity())
//           .toList(); // Convert to entity list
//     } catch (e) {
//       throw Exception('Failed to fetch services from local storage: $e');
//     }
//   }

//   @override
//   Future<ServiceEntity> getServiceById(String id) async {
//     try {
//       final service = await hiveService.getServiceById(id);
//       if (service == null) {
//         throw Exception('Service not found');
//       }
//       return service.toEntity(); // Convert to ServiceEntity
//     } catch (e) {
//       throw Exception('Failed to fetch Service from local storage: $e');
//     }
//   }
// }
