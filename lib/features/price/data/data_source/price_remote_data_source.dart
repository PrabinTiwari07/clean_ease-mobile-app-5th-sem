import 'package:dio/dio.dart';

import '../../domain/entity/price_entity.dart';
import '../model/price_api_model.dart';

class PriceRemoteDataSource {
  final Dio dio;

  PriceRemoteDataSource({required this.dio});

  Future<List<PriceEntity>> fetchPrices() async {
    try {
      final response = await dio.get('http://10.0.2.2:3000/api/prices');

      if (response.statusCode == 200 && response.data is List) {
        return (response.data as List)
            .map((json) => PriceApiModel.fromJson(json)) // ✅ Parse correctly
            .toList();
      } else {
        throw Exception('Invalid API response');
      }
    } on DioException catch (e) {
      throw Exception("API Request Failed: ${e.message}");
    }
  }
}
