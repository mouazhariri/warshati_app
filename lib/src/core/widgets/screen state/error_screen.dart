import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sham/src/core/utils/constants/messages/general_messages.dart';
import 'package:sham/src/core/utils/extenssion/assets_extension.dart';
import 'package:sham/src/core/utils/extenssion/widget_extensions.dart';
import 'package:sham/src/resourses/assets_manager/assets_manager.dart';
import 'package:sham/src/resourses/color_manager/color_provider.dart';

class ErrorScreen extends StatelessWidget {
  final String? error;
  final Function()? onTap;
  const ErrorScreen({
    super.key,
    this.error,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppImages.errorScreen.asImageAssets(width: 250.w, height: 250.h),
          8.verticalSpace,
          Text(
            'Error',
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(fontSize: 24.sp),
          ),
          8.verticalSpace,
          Text(
            error ?? GeneralMessages().someThingWentWrong,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          32.verticalSpace,
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: 0.3.sw,
              height: 40.h,
              decoration: BoxDecoration(
                color: ColorProvider().primary,
                borderRadius: BorderRadius.all(Radius.circular(20.r)),
              ),
              child: Text(
                'Retry',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: ColorProvider().onPrimary,
                      fontSize: 13.sp,
                    ),
              ).centered(),
            ),
          ),
        ],
      ),
    );
  }
}
