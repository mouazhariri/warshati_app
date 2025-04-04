import 'package:flutter/material.dart';

import '../../../../src/resourses/color_manager/color_provider.dart';
import '../widgets/banner_slider.dart';
import '../widgets/home_services_section.dart';
import '../widgets/popular_services_section.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopularServicesSection();
  }
}
