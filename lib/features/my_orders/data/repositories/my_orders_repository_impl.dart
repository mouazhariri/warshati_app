import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sham/features/my_orders/data/datasources/my_orders_remote_data_source.dart';
import 'package:sham/features/my_orders/domain/entities/my_orders_entity.dart';
import 'package:sham/features/my_orders/domain/repositories/my_orders_repository.dart';
import 'package:sham/src/infrastructure/api/response/api_response.dart';
import 'package:sham/src/logger/failure/app_failures.dart';
import 'package:sham/src/logger/failure/exceptions/app_exception.dart';

@LazySingleton(as: MyOrdersRepository)
class MyOrdersRepositoryImpl implements MyOrdersRepository {
  final MyOrdersRemoteDataSource remoteDataSource;

  MyOrdersRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, List<MyOrdersEntity>>> getMyOrders() async {
    try {
      ApiResponse<List<MyOrdersEntity>> response =
          await remoteDataSource.getMyOrders();
      if (response.hasSucceeded) {
        if (response.data == null) {
          return Left(
              ServerFailure(response.message ?? "Something went wrong"));
        } else {
          return Right(response.data!);
        }
      } else {
        return Left(AuthenticationFailure(response.error.toString()));
      }
    } on ServerException catch (error) {
      return Left(ServerFailure(error.errorMessageModel.message));
    }
  }
}
