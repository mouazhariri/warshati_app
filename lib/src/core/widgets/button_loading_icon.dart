import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sham/src/core/utils/extenssion/assets_extension.dart';
import 'package:sham/src/resourses/assets_manager/assets_manager.dart';

class ButtonLoadingIcon extends StatelessWidget {
  const ButtonLoadingIcon({
    super.key,
    this.width,
    this.height,
    this.color,
  });
  final double? width;
  final double? height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return AppLottie.loadingWhite.asLottieAssets(
      width: width ?? 40.w,
      height: height ?? 40.h,
    );
  }
}
