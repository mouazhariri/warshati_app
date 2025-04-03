import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:warshati/src/infrastructure/api/endpoint/base_urls.dart';
import 'package:warshati/src/resourses/assets_manager/assets_manager.dart';

import '../../../resourses/color_manager/color_manager.dart';

extension AssetsExtension on String {
  String get asNetworkImage => "${BaseUrls.networkImagebaseUrl}$this";

  String get asAssetsImage => "${AppImages().assetImagesPath}/$this";

  String get asAssetsIcons => "${AppIcons().assetsIconsPath}/$this";

  String get asAssetsLottie => "${AppLottie().assetsLottiePath}/$this";

  Widget asAssetsSvg({
    double? width,
    double? height,
    Color? color,
    BoxFit? fit,
  }) {
    return SvgPicture.asset(
      this,
      width: width ?? 18.w,
      height: height ?? 18.h,
      colorFilter:
          color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
      fit: fit ?? BoxFit.contain,
    );
  }

  Widget asNetworkSvg({double? width, double? height, Color? color}) {
    return SvgPicture.network(
      this,
      width: width ?? 18.w,
      height: height ?? 18.h,
      colorFilter: color != null
          ? ColorFilter.mode(LightColorsManager().darker, BlendMode.srcIn)
          : null,
    );
  }

  Widget asImageAssets({double? width, double? height}) {
    return Image.asset(
      this,
      width: width ?? 50.w,
      height: height ?? 50.h,
    );
  }

  Widget asImageNetwork({double? width, double? height}) {
    return Image.network(
      this,
      width: width ?? 50.w,
      height: height ?? 50.h,
    );
  }

  Widget asLottieAssets({double? width, double? height}) {
    return Lottie.asset(
      this,
      width: width ?? 50.w,
      height: height ?? 50.h,
    );
  }
}
