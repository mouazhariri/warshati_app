import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:sham/src/infrastructure/api/response/api_response.dart';

import '../../../../features/my_orders/domain/entities/my_orders_entity.dart';
import '../../api/endpoint/api_endpoints.dart';
part 'my_orders_service.g.dart';

@LazySingleton()
@RestApi()
abstract class MyOrdersServices {
  @factoryMethod
  factory MyOrdersServices(Dio dio, {@Named('baseUrl') String baseUrl}) =
      _MyOrdersServices;

  // Create your APIs like:
  @GET(ApiEndPoints.myOrdersService)
  Future<ApiResponse<List<MyOrdersEntity>>> getMyOrders();
}
