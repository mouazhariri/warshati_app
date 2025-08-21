import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sham/features/service_details/data/datasources/remote/service_details_remote_data_source.dart';
import 'package:sham/features/auth/sign_in/data/datasources/remote/sign_in_remote_data_source.dart';
import 'package:sham/features/auth/sign_in/domain/entities/sign_in_params.dart';
import 'package:sham/features/auth/sign_in/domain/repositories/sign_in_repository.dart';
import 'package:sham/src/core/data/models/user_information.dart';
import 'package:sham/src/infrastructure/api/response/api_response.dart';
import 'package:sham/src/logger/failure/app_failures.dart';
import 'package:sham/src/logger/failure/exceptions/app_exception.dart';

import '../../domain/entities/order_Service_params.dart';
import '../../domain/repositories/service_details_repository.dart';

@LazySingleton(as: ServiceDetailsRepository)
class ServiceDetailsRepositoryImpl implements ServiceDetailsRepository {
  final ServiceDetailsRemoteDataSource remoteDataSource;

  ServiceDetailsRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, void>> orderService(OrderServiceParams params) async {
    try {
      ApiResponse<void> response = await remoteDataSource.orderService(params);
      if (response.hasSucceeded) {
        return Right<Failure, void>(null);
      } else {
        //+
        return Left(AuthenticationFailure(response.error.toString())); //+
      }
    } on ServerException catch (error) {
      //+
      return Left(ServerFailure(error.errorMessageModel.message)); //+
    }
  }
}
