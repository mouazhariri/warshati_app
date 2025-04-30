import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sham/src/core/utils/extenssion/assets_extension.dart';
import 'package:sham/src/resourses/assets_manager/assets_manager.dart';

class ButtonSuccesIcon extends StatelessWidget {
  final double? width;
  final double? height;
  const ButtonSuccesIcon({
    super.key,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return AppLottie.successWhite
        .asLottieAssets(width: width ?? 40.w, height: height ?? 40.h);
  }
}
