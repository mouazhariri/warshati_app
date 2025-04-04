import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../src/core/utils/validator/address_validator.dart';
import '../../../../src/resourses/color_manager/color_provider.dart';

class AddressFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String?)? onSaved;

  const AddressFieldWidget({
    super.key,
    required this.controller,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    ColorProvider colorProvider = ColorProvider();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "address".tr(),
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
        ),
        12.verticalSpace,
        TextFormField(
          controller: controller,
          style: TextStyle(color: colorProvider.grey),
          maxLines: 2,
          decoration: InputDecoration(
            hintText: 'enter_your_full_address'.tr(),
            prefixIcon: const Icon(Icons.location_on),
            hintStyle: Theme.of(context)
                .textTheme
                .labelSmall!
                .copyWith(fontSize: 14, color: colorProvider.greyStroke),
          ),
          textInputAction: TextInputAction.next,
          validator: (value) => ValidationUtils.validateAddress(value),
          keyboardType: TextInputType.streetAddress,
          onSaved: onSaved,
        ),
      ],
    );
  }
}
