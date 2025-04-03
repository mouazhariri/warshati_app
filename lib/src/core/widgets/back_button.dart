import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:warshati/src/resourses/color_manager/color_provider.dart';

class CustomeBackButton extends StatelessWidget {
  final Color? color;
  const CustomeBackButton({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Icon(
        Icons.arrow_back_ios_new_rounded,
        color: color ?? ColorProvider().darkest,
        size: 24.sp,
      ),
    );
  }
}
