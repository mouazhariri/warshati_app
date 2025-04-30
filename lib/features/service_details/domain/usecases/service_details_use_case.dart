import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sham/features/service_details/domain/entities/order_Service_params.dart';
import 'package:sham/features/service_details/domain/repositories/service_details_repository.dart';
import 'package:sham/src/application/architecture/use_case/base_usecase.dart';
import 'package:sham/src/logger/failure/app_failures.dart';

@lazySingleton
class ServiceDetailsUseCase extends BaseUseCase<void, OrderServiceParams> {
  final ServiceDetailsRepository baseRepositoryNameRepository;
  ServiceDetailsUseCase({required this.baseRepositoryNameRepository});

  @override
  Future<Either<Failure, void>> call(parameters) async {
    return await baseRepositoryNameRepository.orderService(parameters);
  }
}
