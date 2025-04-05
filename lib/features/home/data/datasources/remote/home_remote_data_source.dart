import 'package:warshati/features/home/domain/entities/services_entity.dart';
import 'package:warshati/src/infrastructure/api/response/api_response.dart';

abstract class HomeRemoteDataSource {
  Future<ApiResponse<List<ServicesEntity>>> getAllServices();
}
