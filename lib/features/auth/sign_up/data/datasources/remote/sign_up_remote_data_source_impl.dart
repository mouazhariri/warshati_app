import 'package:injectable/injectable.dart';
import 'package:sham/features/auth/sign_in/domain/entities/sign_in_params.dart';
import 'package:sham/features/auth/sign_up/data/datasources/remote/sign_up_remote_data_source.dart';
import 'package:sham/src/application/di/injection.dart';
import 'package:sham/src/core/data/models/user_information.dart';
import 'package:sham/src/infrastructure/api/response/api_response.dart';
import 'package:sham/src/infrastructure/services/auth/sign_up_services.dart';

@LazySingleton(as: SignUpRemoteDataSource)
class SignUpRemoteDataSourceImpl implements SignUpRemoteDataSource {
  final SignUpServices _signUpServices = sl<SignUpServices>();

  SignUpRemoteDataSourceImpl({required SignUpServices signUpServices});
  @override
  Future<ApiResponse<UserInformation>> signUp(SignInParams params) async {
    return await _signUpServices.signUp(
      {
        "full_name":params.name,
        "phone_number":params.phoneNumber,
        // "password":"koko123", 
      }
    );
  }
}
