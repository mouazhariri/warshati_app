import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:warshati/src/resourses/color_manager/color_provider.dart';

class DefaultButton extends StatelessWidget {
  final Widget? content;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final Function() onTap;
  final double roundnessLevel;
  final bool isEnable;

  final Color? borderColor;
  const DefaultButton({
    super.key,
    this.content,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height,
    this.borderColor,
    required this.onTap,
    this.roundnessLevel = 35,
    this.isEnable = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 0.8.sw,
      height: height ?? 64.h,
      child: MaterialButton(
        onPressed: isEnable ? onTap : null,
        color: backgroundColor ?? ColorProvider().primary,
        disabledColor: ColorProvider().grey,
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: borderColor != null
              ? BorderSide(
                  color:
                      borderColor ?? backgroundColor ?? ColorProvider().primary,
                  width: 1,
                )
              : BorderSide.none,
          borderRadius: BorderRadius.circular(roundnessLevel.r),
        ),
        child: content,
      ),
    );
  }
}
