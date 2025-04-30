import 'package:sham/features/my_orders/domain/entities/my_orders_entity.dart';
import 'package:sham/src/infrastructure/api/response/api_response.dart';

abstract class MyOrdersRemoteDataSource {
  Future<ApiResponse<List<MyOrdersEntity>>> getMyOrders();
}
