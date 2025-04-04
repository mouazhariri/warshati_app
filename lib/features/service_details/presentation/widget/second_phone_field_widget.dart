import 'package:easy_localization/easy_localization.dart' as local;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:warshati/src/core/utils/extenssion/assets_extension.dart';
import 'package:warshati/src/core/utils/extenssion/widget_extensions.dart';
import 'package:warshati/src/resourses/assets_manager/assets_manager.dart';

import '../../../../../src/core/utils/functions/arabic_number_input_formatter.dart';
import '../../../../../src/core/utils/validator/mobile_validator.dart';
import '../../../../../src/resourses/color_manager/color_provider.dart';

class SecondPhoneFieldWidget extends StatelessWidget {
  const SecondPhoneFieldWidget(
      {super.key, this.onSaved, required this.controller});

  final void Function(String?)? onSaved;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    ColorProvider colorProvider = ColorProvider();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(context.tr("second_phone_number"),
            style: textTheme.displayMedium!.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            )),
        12.verticalSpace,
        Directionality(
          textDirection: TextDirection.ltr,
          child: Row(
            children: [
              _buildPhoneNumberPrefix(context),
              4.horizontalSpace,
              Flexible(
                child: TextFormField(
                  style: TextStyle(color: colorProvider.grey),
                  decoration: InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    hintText: context.tr('second_phone_number_optional'),
                    hintStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
                        fontSize: 14, color: colorProvider.greyStroke),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    ArabicNumberInputFormatter(),
                  ],
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.phone,
                  onSaved: onSaved,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneNumberPrefix(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    ColorProvider colorProvider = ColorProvider();
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: colorProvider.lightGrey),
          borderRadius: BorderRadius.all(Radius.circular(12))),
      width: 70,
      height: 52,
      child: IntrinsicHeight(
        child: Row(
          children: [
            AppIcons.syriaFlage
                .asAssetsSvg(fit: BoxFit.cover)
                .symmetricPadding(horizontal: 6),
            Text(
              '+963',
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorProvider.dark,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
