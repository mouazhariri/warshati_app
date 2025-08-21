import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:sham/features/auth/sign_in/domain/entities/sign_in_params.dart';
import 'package:sham/features/auth/sign_up/presentation/bloc/sign_up_bloc.dart';
import 'package:sham/features/auth/sign_up/presentation/widgets/fields/user_name_form_field.dart';
import 'package:sham/src/application/di/injection.dart';
import 'package:sham/src/application/router/app_routes.dart';
import 'package:sham/src/core/utils/constants/messages/app_messages.dart';
import 'package:sham/src/resourses/color_manager/color_provider.dart';

import '../widgets/fields/phone_number_field_widget.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  AutovalidateMode _autovalidate = AutovalidateMode.disabled;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    final form = _formKey.currentState!;
    if (!form.validate()) {
      setState(() => _autovalidate = AutovalidateMode.onUserInteraction);
      return;
    }
    form.save();

    context.read<SignUpBloc>().add(
          SignUpWithEmailEvent(
            params: SignInParams(
              name: _nameCtrl.text.trim(),
              phoneNumber: _phoneCtrl.text.trim(),
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final color = ColorProvider();
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return BlocProvider<SignUpBloc>(
      create: (_) => sl<SignUpBloc>(),
      child: BlocConsumer<SignUpBloc, SignUpState>(
        listenWhen: (p, n) => p.isLoading != n.isLoading || p.success != n.success || p.message != n.message,
        listener: (context, state) {
          if (state.success) {
            AppMessages.showSuccess(message: state.message.isNotEmpty ? state.message : tr('account_created'));
            context.go(AppRoutes.homeScreen);
          } else if (!state.isLoading && state.message.isNotEmpty) {
            AppMessages.showError(message: state.message);
          }
        },
        builder: (context, state) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              backgroundColor: color.background,
              appBar: AppBar(
                title: Text(tr('create_account')),
                centerTitle: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              body: SafeArea(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minHeight: constraints.maxHeight - 32.h),
                        child: IntrinsicHeight(
                          child: Form(
                            key: _formKey,
                            autovalidateMode: _autovalidate,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                24.verticalSpace,
                                Text(
                                  tr('hi_welcome_to_sham'),
                                  textAlign: TextAlign.start,
                                  style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                                ),
                                8.verticalSpace,
                                Text(
                                  tr('we_happy_to_see_you_signUp'),
                                  style: textTheme.bodyMedium?.copyWith(color: theme.hintColor),
                                ),
                                32.verticalSpace,

                                // Name
                                UserNameFormField(
                                  controller: _nameCtrl,
                                
                                ),
                                8.verticalSpace,
                                Align(
                                  alignment: AlignmentDirectional.centerStart,
                                  child: Text(
                                    tr('user_name_note'),
                                    style: textTheme.bodySmall?.copyWith(
                                      color: color.primary,
                                    ),
                                  ),
                                ),
                                20.verticalSpace,

                                // Phone
                                PhoneNumberField(
                                  controller: _phoneCtrl,
                                  // (Optional) force digits only in your custom field or use:
                               
                                ),

                                const Spacer(),

                                // Submit
                                SizedBox(
                                  height: 48.h,
                                  child: ElevatedButton(
                                    onPressed: state.isLoading ? null : () => _submit(context),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: color.primary,
                                      foregroundColor: color.surface,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                                      elevation: 0,
                                    ),
                                    child: state.isLoading
                                        ? const SizedBox(
                                            height: 22,
                                            width: 22,
                                            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                                          )
                                        : Text(
                                            tr('create_account'),
                                            style: textTheme.titleMedium?.copyWith(
                                              color: color.surface,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                  ),
                                ),

                                16.verticalSpace,

                                // Already have account
                                Center(
                                  child: _RichAction(
                                    prefix: tr('already_have_account') + ' ',
                                    action: tr('login'),
                                    onTap: () => context.go(AppRoutes.signInScreen),
                                  ),
                                ),

                                12.verticalSpace,
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _RichAction extends StatelessWidget {
  final String prefix;
  final String action;
  final VoidCallback onTap;

  const _RichAction({
    required this.prefix,
    required this.action,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final color = ColorProvider();
    return InkWell(
      onTap: onTap,
      child: Text.rich(
        TextSpan(
          text: prefix,
          style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
          children: [
            TextSpan(
              text: action,
              style: textTheme.bodyMedium?.copyWith(
                color: color.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
