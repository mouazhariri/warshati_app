import 'package:sham/features/sign_in/domain/entities/sign_in_params.dart';
import 'package:sham/src/core/data/models/user_information.dart';
import 'package:sham/src/infrastructure/api/response/api_response.dart';

abstract class SignInRemoteDataSource {
  Future<ApiResponse<UserInformation>> signIn(SignInParams params);
}
