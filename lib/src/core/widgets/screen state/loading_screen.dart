import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sham/src/core/utils/extenssion/assets_extension.dart';
import 'package:sham/src/resourses/assets_manager/assets_manager.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    super.key,
    this.width,
    this.height,
  });
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AppLottie.loadingPrimary.asLottieAssets(
        width: width ?? 75.w,
        height: height ?? 75.h,
      ),
    );
  }
}
