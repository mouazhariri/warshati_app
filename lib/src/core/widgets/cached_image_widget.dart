import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CachedImageWidget extends StatelessWidget {
  const CachedImageWidget({
    super.key,
    required this.image,
    this.fit,
    required this.height,
    required this.width,
    this.size,
  });
  final String image;
  final BoxFit? fit;
  final double height;
  final double width;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: CachedNetworkImage(
        imageUrl: image,
        fit: fit ?? BoxFit.fill,
        placeholder: (BuildContext context, String url) => Center(
          child: Container(
            height: 1.sh,
            width: 1.sw,
            color: Colors.grey,
          ),
        ),
        errorWidget: (BuildContext context, String url, dynamic error) =>
            Center(
          child: Container(
            height: 1.sh,
            width: 1.sw,
            color: Colors.grey,
            child: Icon(
              Icons.error,
              size: 50.sp,
            ),
          ),
        ),
      ),
    );
  }
}
