import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:warshati/features/home/domain/repositories/home_repository.dart';
import 'package:warshati/features/sign_in/domain/entities/sign_in_params.dart';
import 'package:warshati/features/sign_in/domain/repositories/sign_in_repository.dart';
import 'package:warshati/src/application/architecture/use_case/base_usecase.dart';
import 'package:warshati/src/core/data/models/user_information.dart';
import 'package:warshati/src/logger/failure/app_failures.dart';

import '../entities/services_entity.dart';

@lazySingleton
class HomeUseCase extends BaseUseCase<List<ServicesEntity>, NoParameters> {
  final HomeRepository baseRepositoryNameRepository;
  HomeUseCase({required this.baseRepositoryNameRepository});

  @override
  Future<Either<Failure, List<ServicesEntity>>> call(parameters) async {
    return await baseRepositoryNameRepository.getAllServices();
  }
}
