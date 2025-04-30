import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sham/features/home/data/datasources/remote/home_remote_data_source.dart';
import 'package:sham/features/home/domain/repositories/home_repository.dart';
import 'package:sham/src/infrastructure/api/response/api_response.dart';
import 'package:sham/src/logger/failure/app_failures.dart';
import 'package:sham/src/logger/failure/exceptions/app_exception.dart';

import '../../domain/entities/services_entity.dart';

@LazySingleton(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, List<ServicesEntity>>> getAllServices() async {
    try {
      ApiResponse<List<ServicesEntity>> response =
          await remoteDataSource.getAllServices();
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
