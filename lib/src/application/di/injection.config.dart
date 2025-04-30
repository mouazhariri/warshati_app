// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter/material.dart' as _i409;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../../features/home/data/datasources/remote/home_remote_data_source.dart'
    as _i1012;
import '../../../features/home/data/datasources/remote/home_remote_data_source_impl.dart'
    as _i207;
import '../../../features/home/data/repositories/home_repository_impl.dart'
    as _i955;
import '../../../features/home/domain/repositories/home_repository.dart'
    as _i834;
import '../../../features/home/domain/usecases/home_use_case.dart' as _i723;
import '../../../features/home/presentation/bloc/home_bloc.dart' as _i84;
import '../../../features/main/presentation/bloc/bloc/main_bloc.dart' as _i726;
import '../../../features/my_orders/data/datasources/my_orders_remote_data_source.dart'
    as _i689;
import '../../../features/my_orders/data/datasources/my_orders_remote_data_source_impl.dart'
    as _i240;
import '../../../features/my_orders/data/repositories/my_orders_repository_impl.dart'
    as _i294;
import '../../../features/my_orders/domain/repositories/my_orders_repository.dart'
    as _i501;
import '../../../features/my_orders/presentation/bloc/my_orders_bloc.dart'
    as _i417;
import '../../../features/service_details/data/datasources/remote/service_details_remote_data_source.dart'
    as _i976;
import '../../../features/service_details/data/datasources/remote/service_details_remote_data_source_impl.dart'
    as _i1014;
import '../../../features/service_details/data/repositories/service_details_repository.dart'
    as _i825;
import '../../../features/service_details/domain/repositories/service_details_repository.dart'
    as _i163;
import '../../../features/service_details/domain/usecases/service_details_use_case.dart'
    as _i485;
import '../../../features/service_details/presentation/bloc/service_details_bloc.dart'
    as _i905;
import '../../../features/sign_in/data/datasources/remote/sign_in_remote_data_source.dart'
    as _i299;
import '../../../features/sign_in/data/datasources/remote/sign_in_remote_data_source_impl.dart'
    as _i983;
import '../../../features/sign_in/data/repositories/sign_in_repository.dart'
    as _i142;
import '../../../features/sign_in/domain/repositories/sign_in_repository.dart'
    as _i68;
import '../../../features/sign_in/domain/usecases/sign_in_use_case.dart'
    as _i1031;
import '../../../features/sign_in/presentation/bloc/sign_in_bloc.dart' as _i535;
import '../../infrastructure/services/get_my_orders_services/my_orders_service.dart'
    as _i683;
import '../../infrastructure/services/home_services.dart' as _i786;
import '../../infrastructure/services/order_service_services.dart' as _i283;
import '../../infrastructure/services/sign_in_services.dart' as _i15;
import '../../infrastructure/storage/local_storage.dart' as _i976;
import 'injection.dart' as _i464;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final registerModule = _$RegisterModule();
  gh.lazySingleton<_i726.MainBloc>(() => _i726.MainBloc());
  gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
  gh.lazySingleton<_i409.GlobalKey<_i409.NavigatorState>>(
      () => registerModule.navigatorKey);
  gh.lazySingleton<_i976.LocalStorage>(() => _i976.LocalStorage());
  gh.lazySingleton<_i976.ServiceDetailsRemoteDataSource>(
      () => _i1014.ServiceDetailsRemoteDataSourceImpl());
  gh.lazySingleton<_i1012.HomeRemoteDataSource>(
      () => _i207.HomeRemoteDataSourceImpl());
  gh.factory<String>(
    () => registerModule.baseUrl,
    instanceName: 'baseUrl',
  );
  gh.lazySingleton<_i689.MyOrdersRemoteDataSource>(
      () => _i240.MyOrdersRemoteDataSourceImpl());
  gh.lazySingleton<_i501.MyOrdersRepository>(() => _i294.MyOrdersRepositoryImpl(
      remoteDataSource: gh<_i689.MyOrdersRemoteDataSource>()));
  gh.lazySingleton<_i417.MyOrdersBloc>(
      () => _i417.MyOrdersBloc(gh<_i501.MyOrdersRepository>()));
  gh.lazySingleton<_i15.SignInServices>(() => _i15.SignInServices(
        gh<_i361.Dio>(),
        baseUrl: gh<String>(instanceName: 'baseUrl'),
      ));
  gh.lazySingleton<_i683.MyOrdersServices>(() => _i683.MyOrdersServices(
        gh<_i361.Dio>(),
        baseUrl: gh<String>(instanceName: 'baseUrl'),
      ));
  gh.lazySingleton<_i283.OrderServiceServices>(() => _i283.OrderServiceServices(
        gh<_i361.Dio>(),
        baseUrl: gh<String>(instanceName: 'baseUrl'),
      ));
  gh.lazySingleton<_i786.HomeServices>(() => _i786.HomeServices(
        gh<_i361.Dio>(),
        baseUrl: gh<String>(instanceName: 'baseUrl'),
      ));
  gh.lazySingleton<_i163.ServiceDetailsRepository>(() =>
      _i825.ServiceDetailsRepositoryImpl(
          remoteDataSource: gh<_i976.ServiceDetailsRemoteDataSource>()));
  gh.lazySingleton<_i299.SignInRemoteDataSource>(() =>
      _i983.SignInRemoteDataSourceImpl(
          signInServices: gh<_i15.SignInServices>()));
  gh.lazySingleton<_i834.HomeRepository>(() => _i955.HomeRepositoryImpl(
      remoteDataSource: gh<_i1012.HomeRemoteDataSource>()));
  gh.lazySingleton<_i485.ServiceDetailsUseCase>(() =>
      _i485.ServiceDetailsUseCase(
          baseRepositoryNameRepository: gh<_i163.ServiceDetailsRepository>()));
  gh.factory<_i905.ServiceDetailsBloc>(
      () => _i905.ServiceDetailsBloc(gh<_i485.ServiceDetailsUseCase>()));
  gh.lazySingleton<_i68.SignInRepository>(() => _i142.SignInRepositoryImpl(
      remoteDataSource: gh<_i299.SignInRemoteDataSource>()));
  gh.lazySingleton<_i1031.SignInUseCase>(() => _i1031.SignInUseCase(
      baseRepositoryNameRepository: gh<_i68.SignInRepository>()));
  gh.lazySingleton<_i723.HomeUseCase>(() => _i723.HomeUseCase(
      baseRepositoryNameRepository: gh<_i834.HomeRepository>()));
  gh.factory<_i535.SignInBloc>(
      () => _i535.SignInBloc(gh<_i1031.SignInUseCase>()));
  gh.lazySingleton<_i84.HomeBloc>(() => _i84.HomeBloc(gh<_i723.HomeUseCase>()));
  return getIt;
}

class _$RegisterModule extends _i464.RegisterModule {}
