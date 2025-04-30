import 'package:injectable/injectable.dart';
import 'package:sham/features/home/data/datasources/remote/home_remote_data_source.dart';
import 'package:sham/features/home/domain/entities/services_entity.dart';
import 'package:sham/features/my_orders/data/datasources/my_orders_remote_data_source.dart';
import 'package:sham/src/application/di/injection.dart';
import 'package:sham/src/infrastructure/api/response/api_response.dart';
import 'package:sham/src/infrastructure/services/get_my_orders_services/my_orders_service.dart';
import 'package:sham/src/infrastructure/services/home_services.dart';

import '../../domain/entities/my_orders_entity.dart';

@LazySingleton(as: MyOrdersRemoteDataSource)
class MyOrdersRemoteDataSourceImpl implements MyOrdersRemoteDataSource {
  final MyOrdersServices _myOrdersServices = sl<MyOrdersServices>();

  @override
  Future<ApiResponse<List<MyOrdersEntity>>> getMyOrders() async {
    return await _myOrdersServices.getMyOrders();
  }
}
