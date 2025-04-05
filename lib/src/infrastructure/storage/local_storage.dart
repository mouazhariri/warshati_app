import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:warshati/src/application/di/injection.dart';
import 'package:warshati/src/core/data/models/user_information.dart';
import 'package:warshati/src/core/data/models/user_local_settings.dart';
import 'package:warshati/src/core/localization/app_languages.dart';
import 'package:warshati/src/core/utils/constants/constants.dart';
import 'package:warshati/src/core/utils/enums/app_theme_types.dart';
import 'package:warshati/src/infrastructure/storage/hive/hive_boxes.dart';
import 'package:warshati/src/infrastructure/storage/hive/locale_adapter.dart';
import 'package:warshati/src/logger/log_services/dev_logger.dart';

@LazySingleton()
class LocalStorage {
//   //---------------------------------------
//   //? Hive Boxes name
//   //---------------------------------------
  static const String _userSettings = HiveBoxesName.userLocaleSettingsBox;
  static const String _userInfo = HiveBoxesName.userInfoBox;

//   //---------------------------------------
//   //? Defualt values
//   // ---------------------------------------
  static UserLocalSettings _defualtUserLocalSettings = UserLocalSettings(
    theme: AppThemeType.light,
    locale: AppLocales.englishLocale.languageCode,
    isFirstTimeOpenApp: true,
  );
  static UserInformation _defualtUserinfo = UserInformation.defaultValue;

//   //---------------------------------------
//    INIT
//   //---------------------------------------

  Future<void> init() async {
    // await Hive.deleteFromDisk();
    try {
      Dev.logLine("HI INIT");

      // Register the LocaleAdapter

      // Open UserLocalSettings box
      var userSettingsBox =
          await Hive.openBox<UserLocalSettings>(_userSettings);

      // Retrieve UserLocalSettings if it exists, otherwise use default
      if (userSettingsBox.isNotEmpty && userSettingsBox.get(0) != null) {
        Dev.logLine("USer settings not empty");
        var userSettings = userSettingsBox.get(0) as UserLocalSettings;
        Dev.logLineWithTag(
          tag: 'UserSettings',
          message:
              'User Settings Stored in Local => ${userSettings.toString()}',
        );
        _defualtUserLocalSettings = userSettings;
        AppLanguages.curreentLocal = Locale(userSettings.locale);
      } else {
        // Save default settings if no user settings found
        Dev.logLineWithTag(
          tag: 'UserSettings',
          message:
              'No User Settings Stored. Saving default ${_defualtUserLocalSettings.toString()}',
        );
        AppLanguages.curreentLocal = Locale(_defualtUserLocalSettings.locale);
        await sl<LocalStorage>().saveUserSettings(_defualtUserLocalSettings);
      }
      // Open UserInformation box
      var userInfoBox = await Hive.openBox<UserInformation>(_userInfo);

      // Retrieve UserInformation if it exists, otherwise use default
      if (userInfoBox.isNotEmpty && userInfoBox.get(0) != null) {
        Dev.logLine("USer settings not empty");
        final String token = await getSecuredString(StorageKeys.securedToken);

        var userInfo = userInfoBox.get(0) as UserInformation;
        Dev.logLineWithTag(
          tag: 'UserInformation',
          message: 'User Information from local => ${userInfo.toString()}',
        );
        if (token == '') {
          _defualtUserinfo = userInfo;
        }
      } else {
        // Save default user info if no user info found
        Dev.logLineWithTag(
          tag: 'UserInformation',
          message: 'No User Information Stored. Saving default info',
        );
        await sl<LocalStorage>().saveUserInfo(_defualtUserinfo);
      }
    } catch (e) {
      Dev.logLine("Error during deletion or re-initialization: $e");
    }

    // await Hive.openBox<UserLocalSettings>(_userSettings).then((value) async {
    //   if (value.get(0) != null) {
    //     Dev.logLineWithTag(
    //       tag: 'UserSettings',
    //       message: 'User Settings Stored in Local=> ${value.get(0).toString()}',
    //     );
    //     _defualtUserLocalSettings = value.get(0) as UserLocalSettings;
    //     AppLanguages.curreentLocal = value.get(0)!.locale;
    //   } else {
    //     Dev.logLineWithTag(
    //       tag: 'UserSettings',
    //       message:
    //           'User Settings [[ARE NOT]] Stored in Local  ||| Save Default ${_defualtUserLocalSettings.toString()}',
    //     );
    //     AppLanguages.curreentLocal = _defualtUserLocalSettings.locale;

    //     await sl<LocalStorage>().saveUserSettings(_defualtUserLocalSettings);
    //   }
    // });

    // await Hive.openBox<UserInformation>(_userInfo).then((value) async {
    //   Dev.logLineWithTag(
    //     tag: 'UserInformation',
    //     message: 'User information from local is ${value.get(0).toString()}',
    //   );
    //   final String token = await getSecuredString(StorageKeys.securedToken);
    //   if (value.get(0) != null) {
    //     if (token == '') {
    //       _defualtUserinfo = value.get(0) as UserInformation;
    //     }
    //   } else {
    //     Dev.logLine("User info default values");
    //     await sl<LocalStorage>().saveUserInfo(_defualtUserinfo);
    //   }
    // });
  }

//   Future<void> deleteUserInfoLocalStorage() async {
//     try {
//       // Close all open Hive boxes

//       // await Hive.deleteBoxFromDisk(_userSettings);
//       // await Hive.deleteBoxFromDisk(_userInfo);
//       // Delete all Hive boxes and data from disk
//       await Hive.deleteFromDisk();
//       Dev.logLine("Local Storage Deleted");
//       await Hive.initFlutter();

//       HiveInitializer.initialize();
//       // Reinitialize Hive after deletion
//       await init();
//     } catch (e) {
//       Dev.logLine("Error during deletion or re-initialization: $e");
//     }
//   }

//   //---------------------------------------
//   //? Getter
//   //---------------------------------------
  Box<UserLocalSettings> get _userSettingsBox =>
      Hive.box<UserLocalSettings>(_userSettings);
  Box<UserInformation> get _userinfoBox => Hive.box<UserInformation>(_userInfo);
  UserLocalSettings get userSettings =>
      _userSettingsBox.get(0) ?? _defualtUserLocalSettings;
  UserInformation get userinformation =>
      _userinfoBox.get(0) ?? _defualtUserinfo;

//   //---------------------------------------
//   //? Setter
//   //---------------------------------------

  Future<void> saveUserSettings(UserLocalSettings settings) async {
    _defualtUserLocalSettings = settings;
    await _userSettingsBox.put(0, settings);
    Dev.logLine("User Settings Stored in Local");
  }

  Future<void> saveUserInfo(UserInformation info) async {
    _defualtUserinfo = info;
    await _userinfoBox.put(0, info);
  }
  // remove all user info data and delete token when logout

  Future<void> removeUserInfo() async {
    await _userinfoBox.delete(0);
  }

  // SET secured string
  Future<void> setSecuredString(String key, String value) async {
    const flutterSecuredStorage = FlutterSecureStorage();
    Dev.logLine(
        "Flutter secured String with key : $key and with value: $value ");
    await flutterSecuredStorage.write(key: key, value: value);
  }

  // GET secured string
  Future<String> getSecuredString(String key) async {
    const flutterSecuredStorage = FlutterSecureStorage();
    Dev.logLine("Flutter secured String get with key : $key ");
    return await flutterSecuredStorage.read(key: key) ?? "";
  }

  // GET secured string
  Future<void> removeSecuredString() async {
    const flutterSecuredStorage = FlutterSecureStorage();
    Dev.logLine("Flutter secured String Removed with key ");
    await flutterSecuredStorage.delete(key: StorageKeys.securedToken);
  }
}
