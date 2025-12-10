import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sham/features/home/presentation/pages/home_page.dart';
import 'package:sham/features/main/presentation/bloc/bloc/main_bloc.dart';
import 'package:sham/features/main/presentation/bloc/bloc/main_event.dart';
import 'package:sham/features/main/presentation/widgets/custom_bottom_navigation_bar_widget.dart';
import 'package:sham/features/main/presentation/widgets/custom_drawer.dart';
import 'package:sham/features/my_orders/presentation/pages/my_order_page.dart';
import 'package:sham/features/profile/presentation/pages/profile_page.dart';
import 'package:sham/src/application/di/injection.dart';
import 'package:sham/src/application/router/app_router.dart';
import 'package:sham/src/application/router/app_routes.dart';
import 'package:sham/src/core/utils/extenssion/assets_extension.dart';
import 'package:sham/src/infrastructure/storage/local_storage.dart';
import 'package:sham/src/resourses/assets_manager/assets_manager.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../src/core/utils/constants/constants.dart';
import '../../../../src/resourses/color_manager/color_provider.dart';
import '../../../home/presentation/widgets/popular_services_section.dart';
import '../bloc/bloc/main_state.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  static final List<Widget> _pages = [
    HomePage(),
    MyOrdersPage(),

    // Center(child: Text("Soon.....", style: TextStyle(fontSize: 20))),
    ProfilePage(),
  ];
  // int _selectedIndex = 0;

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final MainBloc bloc = sl<MainBloc>();
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    ColorProvider colorProvider = ColorProvider();
    return BlocConsumer<MainBloc, MainState>(
      bloc: bloc,
      listener: (context, state) {
        if (state.logOut) {
          context.go(AppRoutes.signInScreen);
          // context.pushReplacement(AppRoutes.signInScreen);
          // Navigator.of(context).pushNamedAndRemoveUntil(
          //     AppRoutes.signInScreen, (Route<dynamic> route) => false);
        }
      },
      builder: (context, state) {
        return Scaffold(
          key: scaffoldKey,
          extendBody: true,
          resizeToAvoidBottomInset: false,
          drawer: const CustomDrawer(),
          appBar: _mainAppbar(context, textTheme),
          body: _pages[state.selectedIndex],
          bottomNavigationBar: CustomBottomNavigationBarWidget(
            selectedIndex: state.selectedIndex,
            onItemTapped: (index) => bloc.add(
              ChangeBottomItemEvent(selectedItem: index),
            ),
          ),
        );
      },
    );
  }

  _mainAppbar(BuildContext context, TextTheme textTheme) {
    return AppBar(
      centerTitle: true,
      title: Text(
        'welcome'.tr(),
        style: textTheme.titleLarge!
            .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {
          scaffoldKey.currentState?.openDrawer();
        },
      ),
      actions: [AppImages.shamImage.asImageAssets(height: 50, width: 50)],
    );
  }
}
