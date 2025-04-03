import 'package:flutter/material.dart';

import '../../../../src/resourses/color_manager/color_provider.dart';
import '../widgets/banner_slider.dart';
import '../widgets/home_services_section.dart';
import '../widgets/popular_services_section.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          const BannerSlider(),
          const SizedBox(height: 30),
          const HomeServicesSection(),
          const SizedBox(height: 20),
          const PopularServicesSection(),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
