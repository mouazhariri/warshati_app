import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../src/core/widgets/cached_image_widget.dart';
import '../../../../src/resourses/color_manager/color_provider.dart';

class BannerSlider extends StatefulWidget {
  const BannerSlider({super.key});

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  int _currentPage = 0;

  final List<String> bannerImages = [
    'https://img.freepik.com/premium-vector/special-offers-arabic-typography-unique-typo-your-sale-offers-banner-poster-ads_814114-27.jpg',
    'https://forsapro.com/wp-content/uploads/2018/03/%D8%AF%D9%87%D8%A7%D9%86%D8%A7%D8%AA-%D9%88-%D8%AA%D8%B4%D8%B7%D9%8A%D8%A8%D8%A7%D8%AA-%D9%88-%D8%AF%D9%8A%D9%83%D9%88%D8%B1%D8%A7%D8%AA.jpg',
    'https://syrianguides.com/wp-content/uploads/2024/08/damascus-ajami-artwood.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    ColorProvider colorProvider = ColorProvider();
    return Column(
      children: [
        CarouselSlider(
          items: bannerImages.map((imageUrl) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedImageWidget(
                image: imageUrl,
                height: 180,
                width: MediaQuery.of(context).size.width,
              ),
            );
          }).toList(),
          options: CarouselOptions(
            height: 180,
            enlargeCenterPage: true,
            enableInfiniteScroll: false,
            autoPlay: true,
            onPageChanged: (index, reason) {
              setState(() {
                _currentPage = index;
              });
            },
          ),
        ),
        14.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            bannerImages.length,
            (index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: _currentPage == index ? 30 : 8,
              height: 8,
              decoration: BoxDecoration(
                // shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(40)),
                color: _currentPage == index
                    ? colorProvider.primary
                    : colorProvider.lightGrey,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
