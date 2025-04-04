import 'package:easy_localization/easy_localization.dart';

class ValidationUtils {
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter phone number';
    }
    if (!RegExp(r'^[0-9]{10,15}$').hasMatch(value)) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  static String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'address_required'.tr();
    }
    if (value.length < 10) {
      return 'inputed_address_short'.tr();
    }
    return null;
  }
}
