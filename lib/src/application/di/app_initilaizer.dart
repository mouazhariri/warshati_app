import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:warshati/src/application/di/injection.dart';
import 'package:warshati/src/application/router/app_router.dart';
import 'package:warshati/src/infrastructure/api/endpoint/base_urls.dart';
import 'package:warshati/src/infrastructure/storage/hive/hive_initializer.dart';
import 'package:warshati/src/infrastructure/storage/local_storage.dart';

abstract class AppInitilaizer {
  static init() async {
    //-- Flutter init --
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    //-- ENV FILE LOAD  --
    await dotenv.load(fileName: ".env");
    //-- Router init --
    // AppRouter.init();
    //-- Hive initialize --
    await Hive.initFlutter();
    await HiveInitializer.initialize();
    //-- Dependency inijection  --
    configurationDependencies();
    await sl<LocalStorage>().init();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

    //-- Localization init  --
    await EasyLocalization.ensureInitialized();
    //-- Load base URL's  --
    BaseUrls.init();
  }
}
