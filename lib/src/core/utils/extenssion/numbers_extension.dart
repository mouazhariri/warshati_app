import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:sham/src/core/localization/app_languages.dart';

extension IntFormatting on int {
  /// Formats the number with K, M, B for thousands, millions, and billions respectively.
  String get formatted {
    if (this >= 1000000000) {
      return '${(this / 1000000000).toStringAsFixed(1)}B';
    } else if (this >= 1000000) {
      return '${(this / 1000000).toStringAsFixed(1)}M';
    } else if (this >= 1000) {
      return '${(this / 1000).toStringAsFixed(1)}K';
    } else {
      return toString();
    }
  }

  /// Add currency
  String get withCurrency {
    if (AppLanguages.isArabic) {
      final formatter = NumberFormat.decimalPattern('ar');
      return '${formatter.format(this)} ل.س';
    } else {
      final formatter = NumberFormat.decimalPattern('en');
      return '${formatter.format(this)} SYP';
    }
  }
}

extension DoubleToValues on double {
//   /// Convert double to radius values
  Radius get toRadius {
    return Radius.circular(this);
  }

  String get withDistance {
    if (AppLanguages.isArabic) {
      return '$this كم';
    } else {
      return '$this km';
    }
  }
}

extension DoubleFormatting on double {
  /// Add currency
  String get withCurrency {
    if (AppLanguages.isArabic) {
      final formatter = NumberFormat.decimalPattern('ar');
      return '${formatter.format(this)} ل.س';
    } else {
      final formatter = NumberFormat.decimalPattern('en');
      return '${formatter.format(this)} SYP';
    }
  }

  String toCommaSeparated({String locale = 'en'}) {
    final formatter = NumberFormat.decimalPattern(locale);
    return formatter.format(this);
  }
}

extension IntToValues on int {
  /// Convert double to radius values
  Radius get toRadius {
    return Radius.circular(toDouble().r);
  }
}

extension DistanceFormatting on double {
  String toDistanceString() {
    if (this < 1000) {
      return '${toStringAsFixed(2)} m';
    } else {
      return '${(this / 1000).toStringAsFixed(2)} km';
    }
  }
}
