import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sham/features/sign_in/domain/entities/sign_in_params.dart';
import 'package:sham/features/sign_in/presentation/bloc/sign_in_bloc.dart';
import 'package:sham/features/sign_in/presentation/widgets/fields/user_name_form_field.dart';
import 'package:sham/src/application/di/injection.dart';
import 'package:sham/src/application/router/app_router.dart';
import 'package:sham/src/application/router/app_routes.dart';
import 'package:sham/src/core/utils/constants/messages/app_messages.dart';
import 'package:sham/src/core/utils/extenssion/assets_extension.dart';
import 'package:sham/src/core/widgets/screen%20state/error_screen.dart';
import 'package:sham/src/resourses/assets_manager/assets_manager.dart';
import 'package:sham/src/resourses/color_manager/color_provider.dart';

import '../widgets/fields/phone_number_field_widget.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    ColorProvider colorProvider = ColorProvider();
    return BlocProvider<SignInBloc>(
      create: (context) => sl<SignInBloc>(),
      child: BlocConsumer<SignInBloc, SignInState>(
        listener: (context, state) {
          if (state.success) {
            debugPrint("SUCESSSSS!");
            AppMessages.showSuccess(message: state.message);
            context.push(AppRoutes.homeScreen);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: colorProvider.background,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          50.verticalSpace,
                          Text(
                            'hi_welcome_to_sham'.tr(),
                            textAlign: TextAlign.center,
                            style: textTheme.displayMedium!
                                .copyWith(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                )
                                .copyWith(fontSize: 20),
                          ),
                          20.verticalSpace,
                          Text('we_happy_to_see_you'.tr(),
                              textAlign: TextAlign.center,
                              style: textTheme.displayMedium!.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              )),
                          55.verticalSpace,
                          UserNameFormField(
                            controller: nameController,
                          ),
                          25.verticalSpace,
                          PhoneNumberField(controller: phoneController),
                          100.verticalSpace,
                          Column(
                            children: [
                              state.isLoading
                                  ? CircularProgressIndicator(
                                      color: colorProvider.primary,
                                    )
                                  : PrimaryButton(
                                      elevation: 0,
                                      onTap: () {
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();
                                          // context.push(AppRoutes.homeScreen);

                                          context
                                              .read<SignInBloc>()
                                              .add(SignInWithEmailEvent(
                                                params: SignInParams(
                                                  name: nameController.text,
                                                  phoneNumber:
                                                      phoneController.text,
                                                ),
                                              ));
                                        }
                                      },
                                      text: 'LogIn',
                                      bgColor: colorProvider.primary,
                                      borderRadius: 12,
                                      height: 46,
                                      width: 327,
                                      textColor: colorProvider.surface,
                                      fontSize: 16,
                                    ),
                              // 212.verticalSpace,
                            ],
                          ),
                        ]),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class PrimaryButton extends StatefulWidget {
  final VoidCallback onTap;
  final String text;
  final double? width;
  final double? height;
  final double? borderRadius, elevation;
  final double? fontSize;
  final IconData? iconData;
  final Color? textColor, bgColor;
  const PrimaryButton(
      {Key? key,
      required this.onTap,
      required this.text,
      this.width,
      this.height,
      this.elevation = 5,
      this.borderRadius,
      this.fontSize,
      required this.textColor,
      required this.bgColor,
      this.iconData})
      : super(key: key);

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Duration _animationDuration = const Duration(milliseconds: 300);
  final Tween<double> _tween = Tween<double>(begin: 1.0, end: 0.95);
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: _animationDuration,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    ColorProvider colorProvider = ColorProvider();
    return BlocBuilder<SignInBloc, SignInState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            _controller.forward().then((_) {
              _controller.reverse();
            });
            widget.onTap();
          },
          child: ScaleTransition(
            scale: _tween.animate(
              CurvedAnimation(
                parent: _controller,
                curve: Curves.easeOut,
                reverseCurve: Curves.easeIn,
              ),
            ),
            child: Card(
              elevation: widget.elevation ?? 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius!),
              ),
              child: Container(
                height: widget.height ?? 55,
                alignment: Alignment.center,
                width: widget.width ?? double.maxFinite,
                decoration: BoxDecoration(
                  color: widget.bgColor,
                  borderRadius: BorderRadius.circular(widget.borderRadius!),
                ),
                child: state.isLoading
                    ? AppLottie.loadingWhite.asLottieAssets(
                        width: 40.w,
                        height: 40.h,
                      )
                    : Text(
                        widget.text,
                        style: textTheme.displayMedium!
                            .copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            )
                            .copyWith(
                                color: widget.textColor,
                                fontWeight: FontWeight.w500,
                                fontSize: widget.fontSize),
                      ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class PrimaryTextButton extends StatelessWidget {
  const PrimaryTextButton(
      {super.key,
      required this.onPressed,
      required this.title,
      required this.textStyle});
  final Function() onPressed;
  final String title;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Text(
        title,
        style: textStyle,
      ),
    );
  }
}

// class PrimaryTextFormField extends StatelessWidget {
//   PrimaryTextFormField(
//       {super.key,
//       required this.hintText,
//       this.keyboardType,
//       required this.controller,
//       required this.width,
//       required this.height,
//       this.hintTextColor,
//       this.onChanged,
//       this.onTapOutside,
//       this.prefixIcon,
//       this.prefixIconColor,
//       this.inputFormatters,
//       this.maxLines,
//       this.borderRadius});
//   final BorderRadiusGeometry? borderRadius;

//   final String hintText;

//   final List<TextInputFormatter>? inputFormatters;
//   Widget? prefixIcon;
//   Function(PointerDownEvent)? onTapOutside;
//   final Function(String)? onChanged;
//   final double width, height;
//   TextEditingController controller;
//   final Color? hintTextColor, prefixIconColor;
//   final TextInputType? keyboardType;
//   final int? maxLines;
//   @override
//   Widget build(BuildContext context) {
//     ThemeData theme = Theme.of(context);
//     TextTheme textTheme = theme.textTheme;
//     ColorProvider colorProvider = ColorProvider();
//     InputBorder enabledBorder = InputBorder.none;
//     InputBorder focusedErrorBorder = InputBorder.none;
//     InputBorder errorBorder = InputBorder.none;
//     InputBorder focusedBorder = InputBorder.none;

//     return Container(
//       width: width,
//       height: height,
//       decoration: BoxDecoration(
//           borderRadius: borderRadius, color: colorProvider.background),
//       child: TextFormField(
//         controller: controller,
//         maxLines: maxLines,
//         keyboardType: keyboardType,
//         style: textTheme.displayMedium!
//             .copyWith(
//               fontSize: 14,
//               fontWeight: FontWeight.w500,
//             )
//             .copyWith(
//               color: colorProvider.grey,
//             ),
//         decoration: InputDecoration(
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.all(Radius.circular(20)),
//           ),
//           contentPadding:
//               const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
//           filled: true,
//           hintText: hintText,
//           hintStyle: textTheme.displayMedium!
//               .copyWith(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//               )
//               .copyWith(
//                   color: colorProvider.grey,
//                   fontWeight: FontWeight.w600,
//                   fontSize: 14),
//           prefixIcon: prefixIcon,
//           prefixIconColor: prefixIconColor,
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.all(
//               Radius.circular(20),
//             ),
//           ),
//           focusedBorder: focusedBorder,
//           errorBorder: errorBorder,
//           focusedErrorBorder: focusedErrorBorder,
//         ),
//         onChanged: onChanged,
//         inputFormatters: inputFormatters,
//         onTapOutside: onTapOutside,
//       ),
//     );
//   }
// }
