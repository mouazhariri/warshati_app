import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sham/features/sign_in/data/datasources/remote/sign_in_remote_data_source.dart';
import 'package:sham/features/sign_in/domain/entities/sign_in_params.dart';
import 'package:sham/features/sign_in/domain/repositories/sign_in_repository.dart';
import 'package:sham/src/core/data/models/user_information.dart';
import 'package:sham/src/infrastructure/api/response/api_response.dart';
import 'package:sham/src/logger/failure/app_failures.dart';
import 'package:sham/src/logger/failure/exceptions/app_exception.dart';

@LazySingleton(as: SignInRepository)
class SignInRepositoryImpl implements SignInRepository {
  final SignInRemoteDataSource remoteDataSource;

  SignInRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, UserInformation>> signIn(SignInParams params) async {
    try {
      ApiResponse<UserInformation> response =
          await remoteDataSource.signIn(params);
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
