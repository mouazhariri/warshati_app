// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> ar = {
  "this_number_is_already_exist": "هذا الرقم موجود بالفعل.",
  "please_check_your_internet_connection_and_try_again_later": "يرجى التحقق من اتصالك بالإنترنت والمحاولة مرة أخرى لاحقًا.",
  "something_went_wrong_please_try_again_later": "حدث خطأ ما. حاول مرة أخرى لاحقًا.",
  "unauthorized_message": "غير مصرح به. يرجى تسجيل الدخول مرة أخرى.",
  "internal_server_error_message": "خطأ في الخادم الداخلي. حاول مرة أخرى لاحقًا."
};
static const Map<String,dynamic> en = {
  "this_number_is_already_exist": "This number already exists.",
  "please_check_your_internet_connection_and_try_again_later": "Please check your internet connection and try again later.",
  "something_went_wrong_please_try_again_later": "Something went wrong. Please try again later.",
  "unauthorized_message": "Unauthorized. Please log in again.",
  "internal_server_error_message": "Internal server error. Please try again later."
};
static const Map<String, Map<String,dynamic>> mapLocales = {"ar": ar, "en": en};
}
