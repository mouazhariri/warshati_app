import 'package:dartz/dartz.dart';
import 'package:sham/features/service_details/domain/entities/order_Service_params.dart';
import 'package:sham/features/sign_in/domain/entities/sign_in_params.dart';
import 'package:sham/src/core/data/models/user_information.dart';
import 'package:sham/src/logger/failure/app_failures.dart';

abstract class ServiceDetailsRepository {
  Future<Either<Failure, void>> orderService(OrderServiceParams params);
}
