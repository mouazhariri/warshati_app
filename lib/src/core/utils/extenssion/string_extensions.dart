import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension StringExtension on String {
  String capitalize() {
    return this[0].toUpperCase() + substring(1);
  }

  Text toText(TextStyle? style) {
    if (style != null) {
      return Text(
        this,
        style: style,
      );
    } else {
      return Text(
        this,
        style: TextStyle(color: Colors.black, fontSize: 18.sp),
      );
    }
  }

  bool isValidEmail() {
    final emailRegex = RegExp(
      r"[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[-a-zA-Z0-9]{0,61}[a-zA-Z0-9])?\.[a-zA-Z][a-zA-Z0-9]{2,6}",
    );
    return emailRegex.hasMatch(this);
  }

  bool isValidUsername() {
    final usernameRegex = RegExp(r"^[a-zA-Z0-9._-]{3,20}$");
    return usernameRegex.hasMatch(this);
  }

  String formatMoney(String locale, {int decimals = 2}) {
    final formatter =
        NumberFormat.currency(locale: locale, decimalDigits: decimals);
    double? value = double.tryParse(this);
    if (value != null) {
      return formatter.format(value);
    }
    return this; // Return original string if parsing fails
  }

  File toFile() {
    return File(this);
  }

  DateTime toDateTime() {
    final parts = split('-');
    if (parts.length != 3) {
      throw const FormatException('Invalid date format, expected YYYY-MM-DD');
    }

    final year = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final day = int.parse(parts[2]);

    return DateTime(year, month, day);
  }
}

extension StringToAction on String {
  void get copyToClipboard => ClipboardData(text: this);
}
