import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:warshati/features/app/my_app.dart';
import 'package:warshati/src/application/di/app_initilaizer.dart';

void main() async {
  await AppInitilaizer.init();
  // final container = await initializeProviders();
  await handleSplashScreen();
  runApp(const MyApp());
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

  FlutterNativeSplash.remove();
}
