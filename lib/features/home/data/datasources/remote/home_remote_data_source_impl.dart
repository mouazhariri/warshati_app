import 'package:injectable/injectable.dart';
import 'package:sham/features/home/data/datasources/remote/home_remote_data_source.dart';
import 'package:sham/features/home/domain/entities/services_entity.dart';
import 'package:sham/src/application/di/injection.dart';
import 'package:sham/src/infrastructure/api/response/api_response.dart';
import 'package:sham/src/infrastructure/services/home_services.dart';

@LazySingleton(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final HomeServices _homeServices = sl<HomeServices>();

  @override
  Future<ApiResponse<List<ServicesEntity>>> getAllServices() async {
    return await _homeServices.getAllServices();
  }
}
