import 'package:hive/hive.dart';
import 'package:warshati/src/infrastructure/storage/hive/hive_type_ids.dart';
part 'app_theme_types.g.dart';

@HiveType(typeId: HiveTypeIds.themeType)
enum AppThemeType {
  @HiveField(0)
  light,
  @HiveField(1)
  dark,
}
