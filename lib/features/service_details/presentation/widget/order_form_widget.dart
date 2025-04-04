import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:warshati/features/service_details/presentation/widget/address_field_widget.dart';
import 'package:warshati/features/service_details/presentation/widget/day_dropdown_widget.dart';
import 'package:warshati/features/service_details/presentation/widget/second_phone_field_widget.dart';
import 'package:warshati/features/sign_in/presentation/widgets/fields/phone_number_field_widget.dart';
import 'package:warshati/features/sign_in/presentation/widgets/fields/user_name_form_field.dart';
import 'package:warshati/src/core/widgets/default_button.dart';

import '../../../../src/resourses/color_manager/color_provider.dart';

class OrderFormWidget extends StatefulWidget {
  const OrderFormWidget({super.key});

  @override
  State<OrderFormWidget> createState() => _OrderFormWidgetState();
}

class _OrderFormWidgetState extends State<OrderFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _secondPhoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  String? _selectedDay;

  @override
  void dispose() {
    _usernameController.dispose();
    _phoneController.dispose();
    _secondPhoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Form is valid, proceed with submission
      context.pop();
      BotToast.showText(
        text: "order_success".tr(),
        textStyle: TextStyle(fontSize: 16, color: Colors.white),
        contentColor: Colors.green,
        borderRadius: BorderRadius.circular(8),
        duration: Duration(seconds: 3),
        align: Alignment.bottomCenter,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    ColorProvider colorProvider = ColorProvider();
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: 16),
          UserNameFormField(controller: _usernameController),
          const SizedBox(height: 16),
          PhoneNumberField(controller: _phoneController),
          const SizedBox(height: 16),
          SecondPhoneFieldWidget(controller: _secondPhoneController),
          const SizedBox(height: 16),
          DayDropdownWidget(
            selectedDay: _selectedDay,
            onChanged: (value) {
              setState(() {
                _selectedDay = value;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select a day';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          AddressFieldWidget(controller: _addressController),
          const SizedBox(height: 50),
          DefaultButton(
            onTap: _submitForm,
            height: 50,
            roundnessLevel: 12,
            content: Text(
              'Submit Order',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            backgroundColor: colorProvider.primary,
          )
          // ElevatedButton(
          //   onPressed: _submitForm,
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: Theme.of(context).primaryColor,
          //     padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(10),
          //     ),
          //   ),
          //   child: const Text(
          //     'Submit Order',
          //     style: TextStyle(
          //       fontSize: 16,
          //       fontWeight: FontWeight.bold,
          //       color: Colors.white,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
