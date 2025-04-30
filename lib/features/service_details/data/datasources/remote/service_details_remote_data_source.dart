import 'package:sham/features/service_details/domain/entities/order_Service_params.dart';
import 'package:sham/features/sign_in/domain/entities/sign_in_params.dart';
import 'package:sham/src/core/data/models/user_information.dart';
import 'package:sham/src/infrastructure/api/response/api_response.dart';

abstract class ServiceDetailsRemoteDataSource {
  Future<ApiResponse<void>> orderService(OrderServiceParams params);
}
