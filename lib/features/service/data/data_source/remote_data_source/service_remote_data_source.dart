import 'package:clean_ease/app/constants/api_endpoints.dart';
import 'package:clean_ease/features/service/data/model/service_api_model.dart';
import 'package:clean_ease/features/service/domain/entity/service_entity.dart';
import 'package:dio/dio.dart';

class ServiceRemoteDataSource {
  final Dio dio;

  ServiceRemoteDataSource({required this.dio});

  Future<List<ServiceEntity>> getServices() async {
    try {
      print("Fetching services from: ${ApiEndpoints.getAllServices}");
      final response = await dio.get(ApiEndpoints.getAllServices);

      print("Response received: ${response.data}");

      if (response.statusCode == 200) {
        final List data = response.data;
        return data
            .map((json) => ServiceApiModel.fromJson(json).toEntity())
            .toList();
      } else {
        throw Exception('Failed to fetch Services');
      }
    } catch (e) {
      print("Error fetching services: $e");
      throw Exception('Error: ${e.toString()}');
    }
  }

  Future<ServiceEntity> getServiceById(String id) async {
    try {
      final response = await dio.get('${ApiEndpoints.getServiceById}$id');
      if (response.statusCode == 200) {
        final data = response.data;
        return ServiceApiModel.fromJson(data).toEntity();
      } else {
        throw Exception('Failed to fetch Service details');
      }
    } catch (e) {
      throw Exception('Error: ${e.toString()}');
    }
  }
}
