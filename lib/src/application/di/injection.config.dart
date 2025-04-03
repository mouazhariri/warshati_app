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
  gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
  gh.lazySingleton<_i409.GlobalKey<_i409.NavigatorState>>(
      () => registerModule.navigatorKey);
  gh.lazySingleton<_i976.LocalStorage>(() => _i976.LocalStorage());
  gh.factory<String>(
    () => registerModule.baseUrl,
    instanceName: 'baseUrl',
  );
  gh.lazySingleton<_i15.SignInServices>(() => _i15.SignInServices(
        gh<_i361.Dio>(),
        baseUrl: gh<String>(instanceName: 'baseUrl'),
      ));
  gh.lazySingleton<_i299.SignInRemoteDataSource>(() =>
      _i983.SignInRemoteDataSourceImpl(
          signInServices: gh<_i15.SignInServices>()));
  gh.lazySingleton<_i68.SignInRepository>(() => _i142.SignInRepositoryImpl(
      remoteDataSource: gh<_i299.SignInRemoteDataSource>()));
  gh.lazySingleton<_i1031.SignInUseCase>(() => _i1031.SignInUseCase(
      baseRepositoryNameRepository: gh<_i68.SignInRepository>()));
  gh.factory<_i535.SignInBloc>(
      () => _i535.SignInBloc(gh<_i1031.SignInUseCase>()));
  return getIt;
}

class _$RegisterModule extends _i464.RegisterModule {}
