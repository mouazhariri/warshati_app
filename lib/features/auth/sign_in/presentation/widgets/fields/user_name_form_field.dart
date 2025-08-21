import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:queen_validators/queen_validators.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../src/resourses/color_manager/color_provider.dart';

class UserNameFormField extends StatelessWidget {
  
   const UserNameFormField({super.key, this.onSaved, required this.controller, this.enable=false});
  final void Function(String?)? onSaved;
  final TextEditingController controller;
  final bool enable;


  @override
  Widget build(BuildContext context) {

    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    ColorProvider colorProvider = ColorProvider();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(context.tr("user_name"),
            style: textTheme.displayMedium!.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            )),
        12.verticalSpace,
        TextFormField(
          controller: controller,
          style: TextStyle(color: colorProvider.greyBorder),
          readOnly: enable,
          decoration: InputDecoration(
            hintText: context.tr('user_name'),
            hintStyle: Theme.of(context)
                .textTheme
                .labelSmall!
                .copyWith(fontSize: 14, color: colorProvider.greyStroke),
          ),
          textInputAction: TextInputAction.next,
          validator: qValidator([
            IsRequired(context.tr('required')),
            // IsEmail(context.tr('name_valdation_msg'))
          ]),
          keyboardType: TextInputType.name,
          onSaved: onSaved,
        ),
      ],
    );
  }
}
