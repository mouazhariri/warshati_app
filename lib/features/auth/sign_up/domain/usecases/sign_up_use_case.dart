import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sham/features/auth/sign_in/domain/entities/sign_in_params.dart';
import 'package:sham/features/auth/sign_up/domain/repositories/sign_up_repository.dart';
import 'package:sham/src/application/architecture/use_case/base_usecase.dart';
import 'package:sham/src/core/data/models/user_information.dart';
import 'package:sham/src/logger/failure/app_failures.dart';

@lazySingleton
class SignUpUseCase extends BaseUseCase<UserInformation, SignInParams> {
  final SignUpRepository baseRepositoryNameRepository;
  SignUpUseCase({required this.baseRepositoryNameRepository});

  @override
  Future<Either<Failure, UserInformation>> call(parameters) async {
    return await baseRepositoryNameRepository.signUp(parameters);
  }
}
