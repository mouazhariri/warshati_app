import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:warshati/src/core/utils/extenssion/widget_extensions.dart';

import '../../../../src/resourses/color_manager/color_provider.dart';

class CustomBottomNavigationBarWidget extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped; // Update the type for clarity
  CustomBottomNavigationBarWidget({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });
  final List<BottomNavigationBarItem> bottomNavigationBarItems = [
    BottomNavigationBarItem(
        icon: Icon(Icons.home_filled).onlyPadding(top: 10), label: "home".tr()),
    // BottomNavigationBarItem(
    //     icon: Icon(Icons.dataset).onlyPadding(top: 10), label: "orders".tr()),
    BottomNavigationBarItem(
        icon: Icon(Icons.person_2_rounded).onlyPadding(top: 10),
        label: "profile".tr()),
  ];
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    ColorProvider colorProvider = ColorProvider();
    return BottomNavigationBar(
      items: bottomNavigationBarItems,
      currentIndex: selectedIndex,
      onTap: (int index) => onItemTapped(index), // Corrected this line
      selectedItemColor: colorProvider.primary,
      unselectedItemColor: colorProvider.grey,
      backgroundColor: colorProvider.white,
      elevation: 5,
    );
  }
}
