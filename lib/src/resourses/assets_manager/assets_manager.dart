import 'package:sham/src/core/utils/extenssion/assets_extension.dart';

class AppImages {
  static const String _assetsImagesPath = 'assets/images';
  String get assetImagesPath => _assetsImagesPath;
  static String emptyScreen = 'im_empty_screen.png'.asAssetsImage;
  static String errorScreen = 'im_error_screen.png'.asAssetsImage;
  static String logo = 'sham_logo3.png'.asAssetsImage;
  static String shamImage = 'sham.png'.asAssetsImage;
}

class AppIcons {
  static const String _assetsIconsPath = 'assets/icons';
  String get assetsIconsPath => _assetsIconsPath;
  static String syriaFlage = 'syria_flag.svg'.asAssetsIcons;
}

class AppLottie {
  static const String _assetsLottiePath = 'assets/lottie';
  String get assetsLottiePath => _assetsLottiePath;
  static String loadingWhite = 'ic_loading_white.json'.asAssetsLottie;
  static String loadingPrimary = 'ic_loading_primary.json'.asAssetsLottie;
  static String successWhite = 'ic_success_white.json'.asAssetsLottie;
}

class AppGif {
  static const String _assetsGifPath = 'assets/lottie';
  String get assetsGifPath => _assetsGifPath;
  static String splashLogo = 'sham_splash1.gif'.asAssetsLottie;
}
