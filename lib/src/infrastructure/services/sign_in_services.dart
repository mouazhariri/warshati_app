import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:sham/src/core/data/models/user_information.dart';
import 'package:sham/src/infrastructure/api/endpoint/api_endpoints.dart';
import 'package:sham/src/infrastructure/api/response/api_response.dart';
part 'sign_in_services.g.dart';

@LazySingleton()
@RestApi()
abstract class SignInServices {
  @factoryMethod
  factory SignInServices(Dio dio, {@Named('baseUrl') String baseUrl}) =
      _SignInServices;

  // Create your APIs like:
  @POST(ApiEndPoints.signIn)
  Future<ApiResponse<UserInformation>> signIn(
    @Part() Map<String, dynamic> body,
  );
}
