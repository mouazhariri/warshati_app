import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:warshati/features/main/presentation/bloc/bloc/main_bloc.dart';
import 'package:warshati/features/main/presentation/bloc/bloc/main_event.dart';
import 'package:warshati/src/application/di/injection.dart';
import 'package:warshati/src/core/utils/extenssion/widget_extensions.dart';
import 'package:warshati/src/core/widgets/default_button.dart';

import '../../../../src/resourses/color_manager/color_provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    ColorProvider colorProvider = ColorProvider();
    return Column(
      children: [
        20.verticalSpace,
        _buildCustomText(context, textTheme, "الأسم :", "أبو عنتر"),
        25.verticalSpace,
        _buildCustomText(context, textTheme, "الرقم الشخصي :", "099998889"),
        Spacer(),
        DefaultButton(
          onTap: () async {
            sl<MainBloc>().add(LogOutEvent());
          },
          backgroundColor: Colors.red,
          roundnessLevel: 15,
          width: 250,
          height: 55,
          content: Text(
            "تسجيل الخروج",
            style: textTheme.displaySmall!.copyWith(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ),
        80.verticalSpace,
      ],
    ).symmetricPadding(horizontal: 16, vertical: 12);
  }

  _buildCustomText(BuildContext context, TextTheme textTheme, String firstText,
      String secondText) {
    return Row(
      children: [
        Text(
          firstText,
          style: textTheme.displayMedium!.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        25.horizontalSpace,
        Text(
          secondText,
          style: textTheme.displaySmall!.copyWith(
            // fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        )
      ],
    );
  }
}
