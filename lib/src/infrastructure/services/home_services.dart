import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../../features/home/domain/entities/services_entity.dart';
import '../api/endpoint/api_endpoints.dart';
import '../api/response/api_response.dart';
part 'home_services.g.dart';

@LazySingleton()
@RestApi()
abstract class HomeServices {
  @factoryMethod
  factory HomeServices(Dio dio, {@Named('baseUrl') String baseUrl}) =
      _HomeServices;

  // Create your APIs like:
  @GET(ApiEndPoints.homeServices)
  Future<ApiResponse<List<ServicesEntity>>> getAllServices();
}
