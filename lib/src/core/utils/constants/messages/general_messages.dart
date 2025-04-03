import 'package:easy_localization/easy_localization.dart';
import 'package:warshati/generated/locale_keys.g.dart';

class GeneralMessages {
  String get noInternetMessage =>
      LocaleKeys.please_check_your_internet_connection_and_try_again_later.tr();
  String get someThingWentWrong =>
      LocaleKeys.something_went_wrong_please_try_again_later.tr();
  String get unauthorizedMessage => LocaleKeys.unauthorized_message.tr();
  String get internalServerErrorMessage =>
      LocaleKeys.internal_server_error_message.tr();
}
