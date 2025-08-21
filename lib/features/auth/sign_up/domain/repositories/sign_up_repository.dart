import 'package:dartz/dartz.dart';
import 'package:sham/features/auth/sign_in/domain/entities/sign_in_params.dart';
import 'package:sham/src/core/data/models/user_information.dart';
import 'package:sham/src/logger/failure/app_failures.dart';

abstract class SignUpRepository {
  Future<Either<Failure, UserInformation>> signUp(SignInParams params);
}
