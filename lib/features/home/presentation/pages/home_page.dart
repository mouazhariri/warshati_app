import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sham/src/application/router/app_routes.dart';
import 'package:sham/src/core/utils/extenssion/widget_extensions.dart';
import 'package:sham/src/core/widgets/default_button.dart';
import '../../../../src/resourses/color_manager/color_provider.dart';
import '../widgets/popular_services_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorProvider colorProvider = ColorProvider();
    
    return Scaffold(
      body: SafeArea(
        child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // Fixed header section with button
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 25,vertical: 20),
              child: DefaultButton(
                onTap: () => context.pushNamed(AppRoutes.serviceDetails),
                height: 50,
                roundnessLevel: 12,
                content: Text(
                  'order_now'.tr(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                backgroundColor: colorProvider.primary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
                  'our_services'.tr(),
                  style: theme.textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                  ),
                ).onlyPadding(start: 16),
            
            // Scrollable services section
            const PopularServicesSection(),
          ],
        ),
      ),
    );
  }
}