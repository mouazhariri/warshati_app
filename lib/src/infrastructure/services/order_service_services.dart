import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../api/endpoint/api_endpoints.dart';
import '../api/response/api_response.dart';
part 'order_service_services.g.dart';

@LazySingleton()
@RestApi()
abstract class OrderServiceServices {
  @factoryMethod
  factory OrderServiceServices(Dio dio, {@Named('baseUrl') String baseUrl}) =
      _OrderServiceServices;

  // Create your APIs like:
  @POST(ApiEndPoints.orderService)
  Future<ApiResponse<void>> orderService(
    @Part() Map<String, dynamic> body,
  );
}
