import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:warshati/features/main/presentation/page/main_screen.dart';
import 'package:warshati/src/core/utils/extenssion/widget_extensions.dart';

import '../../../../src/application/di/injection.dart';
import '../../../../src/resourses/color_manager/color_provider.dart';
import '../bloc/bloc/main_bloc.dart';
import '../bloc/bloc/main_event.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final MainBloc bloc = sl<MainBloc>();

    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    ColorProvider colorProvider = ColorProvider();

    return BlocProvider(
      create: (context) => bloc,
      child: Drawer(
        elevation: 0,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              // padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 60),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  colorProvider.primary,
                  colorProvider.secondPrimary,
                  colorProvider.thirdPrimary,
                ]),
              ),
              child: Text(
                'Warshati',
                style: textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 2,
                  fontSize: 22,
                ),
              ).centered(),
            ),
            ListTile(
              title: Text(
                "momomo",
                style: textTheme.displaySmall!.copyWith(
                  fontSize: 16,
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: colorProvider.primary,
              ),
              title: Text(
                "الصفحة الرئيسية",
                style: textTheme.displaySmall!.copyWith(
                  fontSize: 16,
                ),
              ),
              onTap: () {
                bloc.add(
                  ChangeBottomItemEvent(selectedItem: 0),
                );
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.person, color: colorProvider.primary),
              title: Text(
                "ملفي الشخصي",
                style: textTheme.displaySmall!.copyWith(
                  fontSize: 16,
                ),
              ),
              onTap: () {
                bloc.add(
                  ChangeBottomItemEvent(selectedItem: 1),
                );
                Navigator.pop(context);
              },
            ),
            50.verticalSpace,
            ListTile(
              leading: Icon(
                Icons.logout_outlined,
                color: Colors.red,
              ),
              title: Text("تسجيل الخروج",
                  style: textTheme.displaySmall!.copyWith(
                    color: Colors.red,

                    // fontWeight: FontWeight.bold,
                    fontSize: 16,
                  )),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
