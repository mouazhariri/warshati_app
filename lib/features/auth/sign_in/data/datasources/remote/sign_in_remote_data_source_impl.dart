import 'package:injectable/injectable.dart';
import 'package:sham/features/auth/sign_in/data/datasources/remote/sign_in_remote_data_source.dart';
import 'package:sham/features/auth/sign_in/domain/entities/sign_in_params.dart';
import 'package:sham/src/application/di/injection.dart';
import 'package:sham/src/core/data/models/user_information.dart';
import 'package:sham/src/infrastructure/api/response/api_response.dart';
import 'package:sham/src/infrastructure/services/auth/sign_in_services.dart';

@LazySingleton(as: SignInRemoteDataSource)
class SignInRemoteDataSourceImpl implements SignInRemoteDataSource {
  final SignInServices _signInServices = sl<SignInServices>();

  // SignInRemoteDataSourceImpl({required SignInServices signInServices});
  @override
  Future<ApiResponse<UserInformation>> signIn(SignInParams params) async {
    return await _signInServices.signIn(params.toMap());
  }
}
