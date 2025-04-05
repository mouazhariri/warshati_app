import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:warshati/features/service_details/domain/entities/order_Service_params.dart';
import 'package:warshati/features/service_details/domain/repositories/service_details_repository.dart';
import 'package:warshati/src/application/architecture/use_case/base_usecase.dart';
import 'package:warshati/src/logger/failure/app_failures.dart';

@lazySingleton
class ServiceDetailsUseCase extends BaseUseCase<void, OrderServiceParams> {
  final ServiceDetailsRepository baseRepositoryNameRepository;
  ServiceDetailsUseCase({required this.baseRepositoryNameRepository});

  @override
  Future<Either<Failure, void>> call(parameters) async {
    return await baseRepositoryNameRepository.orderService(parameters);
  }
}
