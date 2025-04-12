import 'package:dartz/dartz.dart';
import 'package:warshati/src/logger/failure/app_failures.dart';

import '../entities/my_orders_entity.dart';

abstract class MyOrdersRepository {
  Future<Either<Failure, List<MyOrdersEntity>>> getMyOrders();
}
