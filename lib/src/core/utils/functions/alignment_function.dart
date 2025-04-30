import 'package:flutter/material.dart';
import 'package:sham/src/core/localization/app_languages.dart';

Alignment getAlignmentByLocale({bool? isTop, bool? isBottom}) {
  if (isTop != null) {
    if (AppLanguages.isArabic) {
      return Alignment.topRight;
    } else {
      return Alignment.topLeft;
    }
  } else if (isBottom != null) {
    if (AppLanguages.isArabic) {
      return Alignment.bottomRight;
    } else {
      return Alignment.bottomLeft;
    }
  } else {
    if (AppLanguages.isArabic) {
      return Alignment.centerRight;
    } else {
      return Alignment.centerLeft;
    }
  }
}
