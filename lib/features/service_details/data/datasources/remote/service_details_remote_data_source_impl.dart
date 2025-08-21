import 'package:injectable/injectable.dart';
import 'package:sham/src/application/di/injection.dart';
import 'package:sham/src/infrastructure/api/response/api_response.dart';

import '../../../../../src/infrastructure/services/order_service_services.dart';
import '../../../domain/entities/order_Service_params.dart';
import 'service_details_remote_data_source.dart';

@LazySingleton(as: ServiceDetailsRemoteDataSource)
class ServiceDetailsRemoteDataSourceImpl
    implements ServiceDetailsRemoteDataSource {
  final OrderServiceServices _orderServiceServices = sl<OrderServiceServices>();

  @override
  Future<ApiResponse<void>> orderService(OrderServiceParams params) async {
    return await _orderServiceServices.orderService(
  {
    "services":params.servicesId,
    "phone_number":params.phoneNumber,
    "service_day":params.serviceDay,
    "address":params.address,
   if(params.details.isNotEmpty) "details":params.details,
  });
      
      // params.toMap());
  }
}
