import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sham/features/service_details/presentation/screen/service_details_page.dart';
import 'package:sham/src/core/utils/extenssion/widget_extensions.dart';

import '../../../../src/resourses/color_manager/color_provider.dart';

class HomeServicesSection extends StatelessWidget {
  const HomeServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    ColorProvider colorProvider = ColorProvider();
    final List<Map<String, dynamic>> services = [
      {'icon': Icons.carpenter_outlined, 'name': 'Carpenter'},
      {'icon': Icons.electrical_services_rounded, 'name': 'Electrician'},
      {'icon': Icons.hardware, 'name': 'Blacksmith'},
      {'icon': Icons.cleaning_services, 'name': 'Cleaning'},
      {'icon': Icons.plumbing, 'name': 'Plumber'},
      {'icon': Icons.format_paint, 'name': 'Painter'},
      {'icon': Icons.car_repair, 'name': 'Mechanic'},
      {'icon': Icons.construction, 'name': 'Construction'},
      {'icon': Icons.handyman, 'name': 'Builder'},
      {'icon': Icons.architecture, 'name': 'Architects'},
    ];

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'home_services'.tr(),
              style: textTheme.titleMedium!
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'view_all'.tr(),
                style: textTheme.titleMedium!.copyWith(
                    // fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: colorProvider.primary),
              ),
            ),
          ],
        ).symmetricPadding(horizontal: 16),
        const SizedBox(height: 16),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: services.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => ServiceDetailsPage(
                  //       serviceName: services[index]['name'],
                  //       serviceImage: services[index]['image'],
                  //     ),
                  //   ),
                  // );
                },
                child: Container(
                  width: 80,
                  margin: const EdgeInsets.only(right: 16),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          services[index]['icon'],
                          size: 30,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        services[index]['name'],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
