import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:warshati/src/application/di/injection.dart';
import 'package:warshati/src/infrastructure/storage/local_storage.dart';
import 'package:warshati/src/logger/log_services/dev_logger.dart';

abstract class AppLanguages {
  static Locale curreentLocal = AppLocales.defualtLocale;
  static setLocale(BuildContext context, Locale locale) async {
    try {
      EasyLocalization.of(context)!.setLocale(locale);
      curreentLocal = locale;
      await sl<LocalStorage>().saveUserSettings(
        sl<LocalStorage>().userSettings.copyWith(locale: locale.languageCode),
      );
      Dev.logLine('Lang change to $locale');
    } catch (e) {
      Dev.logError(e);
    }
  }

  static Locale get getCurrentLocale {
    return curreentLocal;
  }

//? For compare alignment
  static bool get isArabic => curreentLocal == AppLocales.arabicLocale;
  static bool get isEnglish => curreentLocal == AppLocales.englishLocale;
  static List<Locale> get createSupportedLocals => const [
        AppLocales.englishLocale, // English
        AppLocales.arabicLocale, // Arabic
      ];
  static List<String> get localeNames => const [
        'English',
        'العربية',
      ];
}

class AppLocales {
  static const Locale arabicLocale = Locale('ar');
  static const Locale englishLocale = Locale('en');
  static const Locale defualtLocale = Locale('en');
}
