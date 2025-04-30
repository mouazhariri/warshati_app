// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sham/src/core/utils/extenssion/assets_extension.dart';
import 'package:sham/src/resourses/assets_manager/assets_manager.dart';

class EmptyScreen extends StatelessWidget {
  final String? text;
  final String? image;
  const EmptyScreen({
    super.key,
    this.text,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          image?.asImageAssets(
                width: 200.w,
                height: 200.h,
              ) ??
              AppImages.emptyScreen.asImageAssets(
                width: 200.w,
                height: 200.h,
              ),
          12.verticalSpace,
          Text(
            text ?? 'There is no items',
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ],
      ),
    );
  }
}
