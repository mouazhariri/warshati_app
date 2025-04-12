import 'package:warshati/features/my_orders/domain/entities/my_orders_entity.dart';
import 'package:warshati/src/infrastructure/api/response/api_response.dart';

abstract class MyOrdersRemoteDataSource {
  Future<ApiResponse<List<MyOrdersEntity>>> getMyOrders();
}
