import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:sham/src/core/utils/enums/app_theme_types.dart';

import 'package:sham/src/infrastructure/storage/hive/hive_type_ids.dart';

part 'user_local_settings.g.dart';

@HiveType(typeId: HiveTypeIds.userLocalSettingsId)
class UserLocalSettings extends HiveObject implements EquatableMixin {
  @HiveField(0, defaultValue: true)
  final bool isFirstTimeOpenApp;
  @HiveField(1)
  AppThemeType theme;
  @HiveField(2)
  final String locale;

  UserLocalSettings({
    required this.isFirstTimeOpenApp,
    required this.theme,
    required this.locale,
  });

  UserLocalSettings copyWith({
    bool? isFirstTimeOpenApp,
    AppThemeType? theme,
    String? locale,
  }) {
    return UserLocalSettings(
      isFirstTimeOpenApp: isFirstTimeOpenApp ?? this.isFirstTimeOpenApp,
      theme: theme ?? this.theme,
      locale: locale ?? this.locale,
    );
  }

  @override
  List<Object> get props => [isFirstTimeOpenApp, theme, locale];

  @override
  bool? get stringify => true;

  static UserLocalSettings defaultSettings = UserLocalSettings(
    isFirstTimeOpenApp: false,
    theme: AppThemeType.light,
    locale: 'ar',
  );

  @override
  String toString() =>
      'UserLocalSettings(isFirstTimeOpenApp: $isFirstTimeOpenApp, theme: $theme, locale: $locale)';

  @override
  bool operator ==(covariant UserLocalSettings other) {
    if (identical(this, other)) return true;

    return other.isFirstTimeOpenApp == isFirstTimeOpenApp &&
        other.theme == theme &&
        other.locale == locale;
  }

  @override
  int get hashCode =>
      isFirstTimeOpenApp.hashCode ^ theme.hashCode ^ locale.hashCode;
}
