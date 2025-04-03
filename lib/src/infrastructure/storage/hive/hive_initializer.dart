import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:warshati/src/core/data/models/user_information.dart';
import 'package:warshati/src/core/data/models/user_local_settings.dart';
import 'package:warshati/src/core/utils/enums/app_theme_types.dart';
import 'package:warshati/src/infrastructure/storage/hive/hive_boxes.dart';
import 'package:warshati/src/infrastructure/storage/hive/hive_type_ids.dart';
import 'package:warshati/src/logger/log_services/dev_logger.dart';

abstract class HiveInitializer {
  static Future<void> initialize() async {
    // await Hive.deleteFromDisk();
    Dev.logLine('HiveInitializer');
    try {
      // await Hive.deleteFromDisk();
      var documentsDirectory = await getApplicationDocumentsDirectory();
      Hive.init(documentsDirectory.path);

      bool isNotRegistered(int typeId) {
        return !Hive.isAdapterRegistered(typeId);
      }

      // //* Register Adapters
      if (isNotRegistered(HiveTypeIds.userLocalSettingsId)) {
        Hive.registerAdapter<UserLocalSettings>(UserLocalSettingsAdapter());
      }

      if (isNotRegistered(HiveTypeIds.userInfoTypId)) {
        Hive.registerAdapter<UserInformation>(UserInformationAdapter());
      }
      if (isNotRegistered(HiveTypeIds.themeType)) {
        Hive.registerAdapter<AppThemeType>(AppThemeTypeAdapter());
      }

      //? Open Boxes
      await Hive.openBox<UserLocalSettings>(
          HiveBoxesName.userLocaleSettingsBox);
      await Hive.openBox<UserInformation>(HiveBoxesName.userInfoBox);

      Dev.logSuccess('FINISH HiveInitializer');
    } catch (e) {
      Dev.logError('HiveInitializer Error $e');
    }
  }
}
