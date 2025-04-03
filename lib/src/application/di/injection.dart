import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:warshati/src/application/di/injection.config.dart';
import 'package:warshati/src/infrastructure/api/endpoint/base_urls.dart';
import 'package:warshati/src/infrastructure/network/dio_remote_interceptor.dart';
import 'package:warshati/src/infrastructure/storage/local_storage.dart';

GetIt sl = GetIt.instance;

@module
abstract class RegisterModule {
  @LazySingleton()
  Dio get dio => getDio();
  @Named('baseUrl')
  String get baseUrl => BaseUrls.baseUrl;

  @lazySingleton
  GlobalKey<NavigatorState> get navigatorKey => GlobalKey<NavigatorState>();
}

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
)
Future<void> configurationDependencies() async {
  sl = $initGetIt(sl);
}

Dio getDio() {
  Dio dio = Dio();
  dio.interceptors.clear();
  dio.interceptors.add(
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    ),
  );
  dio.interceptors.add(RemoteInterceptor(sl<LocalStorage>()));

  return dio;
}
