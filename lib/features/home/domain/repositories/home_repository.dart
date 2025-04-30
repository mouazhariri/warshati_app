import 'package:dartz/dartz.dart';
import 'package:sham/src/logger/failure/app_failures.dart';

import '../entities/services_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<ServicesEntity>>> getAllServices();
}
