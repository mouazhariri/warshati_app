import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:warshati/features/service_details/presentation/screen/service_details_page.dart';
import 'package:warshati/src/application/router/app_routes.dart';
import 'package:warshati/src/core/utils/extenssion/widget_extensions.dart';
import 'package:warshati/src/core/widgets/cached_image_widget.dart';

import '../../../../src/resourses/color_manager/color_provider.dart';

class PopularServicesSection extends StatelessWidget {
  const PopularServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    ColorProvider colorProvider = ColorProvider();
    final List<Map<String, dynamic>> popularServices = [
      {
        'image':
            'https://cdn.prod.website-files.com/647888ca92d03e3fca3f1ea0/647888ca92d03e3fca3f2389_carpentry.jpg',
        'name': 'Carpenter workshop',
        'rating': 4.5,
        'price': '10\$/hr',
      },
      {
        'image':
            'https://facts.net/wp-content/uploads/2023/09/20-astonishing-facts-about-blacksmith-1695739626.jpg',
        'name': 'BlackSmith workshop',
        'rating': 4.2,
        'price': '10\$/hr',
      },
      {
        'image': 'https://learnwelding.co.za/images/painting.webp',
        'name': 'Painter workshop',
        'rating': 4.0,
        'price': '10\$/hr',
      },
      {
        'image':
            'https://img.freepik.com/free-photo/man-electrical-technician-working-switchboard-with-fuses_169016-24062.jpg',
        'name': 'Electrical workshop',
        'rating': 4.0,
        'price': '10\$/hr',
      },
    ];

    return Column(
      children: [
        30.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'our_services'.tr(),
              style: textTheme.titleMedium!
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'view_all'.tr(),
                style: textTheme.titleMedium!
                    .copyWith(fontSize: 12, color: colorProvider.primary),
              ),
            ),
          ],
        ),
        16.verticalSpace,
        Expanded(
          child: ListView.separated(
            shrinkWrap: true,
            // scrollDirection: Axis.vertical,
            itemCount: popularServices.length,
            separatorBuilder: (context, index) => 16.verticalSpace,
            itemBuilder: (context, index) {
              final service = popularServices[index];
              return GestureDetector(
                onTap: () {
                  context.pushNamed(
                    AppRoutes.serviceDetails,
                    pathParameters: {
                      'name': service['name'],
                      'image': service['image'],
                    },
                  );

                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => ServiceDetailsPage(
                  //       serviceName: service['name'],
                  //       serviceImage: service['image'],
                  //     ),
                  //   ),
                  // );
                },
                child: Container(
                  width: double.infinity,
                  // margin: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                          child: CachedImageWidget(
                            image: service['image'],
                            height: 120,
                            width: double.infinity,
                          )),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              service['name'],
                              style: textTheme.displaySmall!.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            8.verticalSpace,
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  size: 16,
                                  color: Colors.amber,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  service['rating'].toString(),
                                  style: textTheme.displaySmall!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ],
                            ),
                            12.verticalSpace,
                            Text(
                              'Starting from ${service['price']}',
                              style: textTheme.titleMedium!.copyWith(
                                  fontSize: 12, color: colorProvider.dark),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        80.verticalSpace,
      ],
    ).symmetricPadding(horizontal: 16);
  }
}
