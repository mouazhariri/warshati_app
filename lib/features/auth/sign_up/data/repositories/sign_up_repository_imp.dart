import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sham/features/auth/sign_in/domain/entities/sign_in_params.dart';
import 'package:sham/features/auth/sign_up/data/datasources/remote/sign_up_remote_data_source.dart';
import 'package:sham/features/auth/sign_up/domain/repositories/sign_up_repository.dart';
import 'package:sham/src/core/data/models/user_information.dart';
import 'package:sham/src/infrastructure/api/response/api_response.dart';
import 'package:sham/src/logger/failure/app_failures.dart';
import 'package:sham/src/logger/failure/exceptions/app_exception.dart';

@LazySingleton(as: SignUpRepository)
class SignUpRepositoryImp implements SignUpRepository {
  final SignUpRemoteDataSource remoteDataSource;

  SignUpRepositoryImp({required this.remoteDataSource});
  @override
  Future<Either<Failure, UserInformation>> signUp(SignInParams params) async {
    try {
      ApiResponse<UserInformation> response =
          await remoteDataSource.signUp(params);
      if (response.hasSucceeded) {
        if (response.data == null) {
          return Left(
              ServerFailure(response.message ?? "Something went wrong"));
        } else {
          return Right(response.data!);
        }
      } else {
        return Left(ServerFailure(response.error??"Something went wrong, Try again later"));
      }
    } on ServerException catch (error) {
      return Left(ServerFailure(error.errorMessageModel.message));
    }
  }
}
