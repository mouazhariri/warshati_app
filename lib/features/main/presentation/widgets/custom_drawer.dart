import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:warshati/features/main/presentation/page/main_screen.dart';
import 'package:warshati/src/core/localization/app_languages.dart';
import 'package:warshati/src/core/utils/extenssion/widget_extensions.dart';
import 'package:warshati/src/infrastructure/storage/local_storage.dart';

import '../../../../src/application/di/injection.dart';
import '../../../../src/resourses/color_manager/color_provider.dart';
import '../bloc/bloc/main_bloc.dart';
import '../bloc/bloc/main_event.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
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
                'SHAM',
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
                sl<LocalStorage>().userinformation.name ?? "username",
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
                "home".tr(),
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
                "profile".tr(),
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
            20.verticalSpace,
            ListTile(
              leading:
                  Icon(Icons.language_outlined, color: colorProvider.primary),
              trailing: Switch(
                value: AppLanguages.isArabic,

                // applyCupertinoTheme: true,
                inactiveTrackColor: colorProvider.greyBorder,
                inactiveThumbColor: colorProvider.black,

                trackOutlineColor: WidgetStatePropertyAll(colorProvider.white),
                onChanged: (newValue) {
                  setState(() {
                    Locale locale = newValue
                        ? AppLocales.arabicLocale
                        : AppLocales.englishLocale;
                    AppLanguages.setLocale(context, locale);
                  });
                },
              ),
              title: Text(
                "change_language".tr(),
                style: textTheme.displaySmall!.copyWith(
                  fontSize: 16,
                ),
              ),
              onTap: () {
                bool isArabic = AppLanguages.isArabic;
                Locale locale = isArabic
                    ? AppLocales.arabicLocale
                    : AppLocales.englishLocale;
                AppLanguages.setLocale(context, locale);
                Navigator.pop(context);
              },
            ),
            50.verticalSpace,
            ListTile(
              leading: Icon(
                Icons.logout_outlined,
                color: Colors.red,
              ),
              title: Text("logOut".tr(),
                  style: textTheme.displaySmall!.copyWith(
                    color: Colors.red,

                    // fontWeight: FontWeight.bold,
                    fontSize: 16,
                  )),
              onTap: () {
                sl<MainBloc>().add(LogOutEvent());
              },
            ),
          ],
        ),
      ),
    );
  }
}
