import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sham/features/auth/sign_in/data/datasources/remote/sign_in_remote_data_source.dart';
import 'package:sham/features/auth/sign_in/domain/entities/sign_in_params.dart';
import 'package:sham/features/auth/sign_in/domain/repositories/sign_in_repository.dart';
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
    // try {
      ApiResponse<UserInformation> response =
          await remoteDataSource.signIn(params);
       if (response.hasSucceeded) {
        final data = response.data;
        if (data == null) {
          return Left(ServerFailure(response.message ?? "Something went wrong"));
        }
        return Right(data);
      } else {
        // ✅ Use message first; fall back to error/data if needed
        final msg = response.message ??
            (response.error?.toString()) ??
            "Authentication failed";
        return Left(AuthenticationFailure(msg));
      }
    // } on ServerException catch (error) {
    //   return Left(ServerFailure(error.errorMessageModel.message));
    // }
  }
}
