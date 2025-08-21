import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:queen_validators/queen_validators.dart';

String? Function(String?) mobileNumberValidation(BuildContext context) {
  return qValidator([
    IsRequired(context.tr('required')),
    // MaxLength(10, context.tr('mustBeTenDigits')),
    // MinLength(10, context.tr('mustBeTenDigits')),
    // RegExpRule(
    //   RegExp(r'^([09])\d+'),
    //   context.tr('phoneNumberValidator'),
    // ),
  ]);
}
