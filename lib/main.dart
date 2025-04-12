import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:warshati/features/app/my_app.dart';
import 'package:warshati/features/home/presentation/bloc/home_bloc.dart';
import 'package:warshati/features/home/presentation/bloc/home_event.dart';
import 'package:warshati/src/application/di/app_initilaizer.dart';
import 'package:warshati/src/application/di/injection.dart';
import 'package:warshati/src/infrastructure/storage/local_storage.dart';

import 'src/application/router/app_routes.dart';
import 'src/core/utils/constants/constants.dart';

void main() async {
  await AppInitilaizer.init();
  // final container = await initializeProviders();
  await handleSplashScreen();
}

Future<void> handleSplashScreen() async {
  const minSplashDuration = 2000;
  final startTime = DateTime.now();
  // await container.read(homeProvider.future);
  final loadDuration = DateTime.now().difference(startTime).inMilliseconds;

  if (loadDuration < minSplashDuration) {
    await Future.delayed(
        Duration(milliseconds: minSplashDuration - loadDuration));
  }
  final localStorage = sl<LocalStorage>();
  final token = await localStorage.getSecuredString(StorageKeys.securedToken);
  final initialRoute =
      token.isEmpty ? AppRoutes.signInScreen : AppRoutes.homeScreen;
  FlutterNativeSplash.remove();
  runApp(
    MultiBlocProvider(
        providers: [
          BlocProvider<HomeBloc>(
            create: (context) => sl<HomeBloc>()..add(GetAllServicesEvent()),
          ),
        ],
        child: MyApp(
          initialRoute: initialRoute,
        )),
  );
}
