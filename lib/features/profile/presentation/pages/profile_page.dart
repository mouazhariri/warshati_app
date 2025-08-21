import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sham/features/main/presentation/bloc/bloc/main_bloc.dart';
import 'package:sham/features/main/presentation/bloc/bloc/main_event.dart';
import 'package:sham/src/application/di/injection.dart';
import 'package:sham/src/core/utils/extenssion/widget_extensions.dart';
import 'package:sham/src/core/widgets/default_button.dart';

import '../../../../src/infrastructure/storage/local_storage.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final storage = sl<LocalStorage>();
    final name = storage.userinformation.name?.trim();
    final phone = storage.userinformation.phoneNumber?.trim();
    final initials = _initialsFromName(name);

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _Header(
              initials: initials,
              title: name?.isNotEmpty == true ? name! : "—",
              subtitle: phone?.isNotEmpty == true ? phone! : "—",
            ),
            16.verticalSpace,
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Column(
                  children: [
                    _ProfileItem(
                      label: "name".tr(),
                      value: name ?? "—",
                      leading: const Icon(Icons.person_outline),
                    ),
                    const Divider(height: 24),
                    _ProfileItem(
                      label: "phoneNumber".tr(),
                      value: phone ?? "—",
                      leading: const Icon(Icons.phone_outlined),
                      trailing: IconButton(
                        tooltip: tr("copy"),
                        icon: const Icon(Icons.copy_rounded),
                        onPressed: phone == null || phone.isEmpty
                            ? null
                            : () async {
                                await Clipboard.setData(
                                    ClipboardData(text: phone));
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text(tr("تم النسخ "))),
                                  );
                                }
                              },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            200.verticalSpace,
            // Spacer(),
            DefaultButton(
              onTap: () => _confirmLogout(context),
              backgroundColor: Colors.red,
              roundnessLevel: 15,
              width: double.infinity,
              height: 55,
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.logout_rounded,color: Colors.white,),
                  10.horizontalSpace,
                  Text(
                    "logOut".tr(),
                    style: textTheme.displaySmall!.copyWith(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ).centered(),
                ],
              ),
            ).symmetricPadding(horizontal: 60),
          ],
        ),
      ),
    );
  }

  static String _initialsFromName(String? name) {
    if (name == null || name.trim().isEmpty) return "👤";
    final parts = name.trim().split(RegExp(r'\s+'));
    final first = parts.isNotEmpty ? parts.first.characters.first : "";
    final last = parts.length > 1 ? parts.last.characters.first : "";
    final initials = (first + last).toUpperCase();
    return initials.isEmpty ? "👤" : initials;
  }

  void _confirmLogout(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(tr("logOut")),
        content: Text(tr("logout_confirmation")),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(tr("cancel")),
          ),
          // Spacer(),
          20.horizontalSpace,
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(tr("logOut")),
          ),
        ],
      ),
    );
    if (result == true) {
      sl<MainBloc>().add(LogOutEvent());
    }
  }
}

class _Header extends StatelessWidget {
  final String initials;
  final String title;
  final String subtitle;

  const _Header({
    required this.initials,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary.withOpacity(0.10),
            theme.colorScheme.primary.withOpacity(0.04),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 32.r,
            backgroundColor: theme.colorScheme.primary.withOpacity(0.15),
            child: Text(
              initials,
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w700)),
                4.verticalSpace,
                Text(subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: theme.hintColor)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileItem extends StatelessWidget {
  final String label;
  final String value;
  final Widget? leading;
  final Widget? trailing;

  const _ProfileItem({
    required this.label,
    required this.value,
    this.leading,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: leading,
      title: Text(label,
          style: theme.textTheme.bodyMedium
              ?.copyWith(fontWeight: FontWeight.w600)),
      subtitle: Text(value, style: theme.textTheme.bodyLarge),
      trailing: trailing,
    );
  }
}
