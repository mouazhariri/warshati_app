import 'package:flutter/material.dart';
import 'package:warshati/features/home/presentation/pages/home_page.dart';
import 'package:warshati/features/main/presentation/widgets/custom_bottom_navigation_bar_widget.dart';
import 'package:warshati/features/main/presentation/widgets/custom_drawer.dart';
import 'package:warshati/src/core/utils/extenssion/assets_extension.dart';
import 'package:warshati/src/resourses/assets_manager/assets_manager.dart';

import '../../../src/resourses/color_manager/color_provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  static final List<Widget> _pages = [
    HomePage(),
    Center(child: Text("Soon.....", style: TextStyle(fontSize: 20))),
    Center(child: Text("Profile Page", style: TextStyle(fontSize: 20))),
  ];
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    ColorProvider colorProvider = ColorProvider();
    return Scaffold(
      key: scaffoldKey,
      extendBody: true,
      resizeToAvoidBottomInset: false,
      drawer: const CustomDrawer(),
      appBar: _mainAppbar(context, textTheme),
      body: _pages[_selectedIndex],
      bottomNavigationBar: CustomBottomNavigationBarWidget(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  _mainAppbar(BuildContext context, TextTheme textTheme) {
    return AppBar(
      centerTitle: true,
      title: Text(
        'Welcome to Warshati',
        style: textTheme.titleLarge!
            .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {
          scaffoldKey.currentState?.openDrawer();
        },
      ),
      actions: [AppImages.warshatiImage.asImageAssets(height: 50, width: 50)],
    );
  }
}
