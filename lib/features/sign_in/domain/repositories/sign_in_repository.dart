import 'package:dartz/dartz.dart';
import 'package:warshati/features/sign_in/domain/entities/sign_in_params.dart';
import 'package:warshati/src/core/data/models/user_information.dart';
import 'package:warshati/src/logger/failure/app_failures.dart';

abstract class SignInRepository {
  Future<Either<Failure, UserInformation>> signIn(SignInParams params);
}
