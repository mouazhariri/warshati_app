
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sham/features/service_details/domain/entities/order_Service_params.dart';
import 'package:sham/features/service_details/presentation/bloc/service_details_bloc.dart';
import 'package:sham/features/service_details/presentation/widget/address_field_widget.dart';
import 'package:sham/features/service_details/presentation/widget/day_dropdown_widget.dart';
import 'package:sham/features/auth/sign_in/presentation/widgets/fields/phone_number_field_widget.dart';
import 'package:sham/features/service_details/presentation/widget/details_field.dart';
import 'package:sham/features/service_details/presentation/widget/name_form.dart';
import 'package:sham/features/service_details/presentation/widget/phone_number_field_form.dart';
import 'package:sham/src/core/widgets/default_button.dart';

import '../../../../src/resourses/color_manager/color_provider.dart';

class OrderFormWidget extends StatefulWidget {
  final int? serviceId;
final List<int> selectedIds;

  const OrderFormWidget({super.key, required this.serviceId,required this.selectedIds});

  @override
  State<OrderFormWidget> createState() => _OrderFormWidgetState();
}

class _OrderFormWidgetState extends State<OrderFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _secondPhoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  String? _selectedDay;

  @override
  void dispose() {
    _usernameController.dispose();
    _phoneController.dispose();
    _secondPhoneController.dispose();
    _addressController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  void _submitForm(context, ServiceDetailsBloc bloc) {
    if (_formKey.currentState!.validate()) {
      // Form is valid, proceed with submission
      bloc.add(OrderServiceEvent(
        params: OrderServiceParams(
          name: _usernameController.text,
          servicesId: widget.selectedIds,
          phoneNumber: _phoneController.text,
          serviceDay: _selectedDay??"آقرب يوم",
          address:  _addressController.text,
          details:  _detailsController.text,
          userId: 0,
        ),
      ));
    
    }
  }

  @override
  Widget build(BuildContext context) {
    final ServiceDetailsBloc bloc = context.read<ServiceDetailsBloc>();
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    ColorProvider colorProvider = ColorProvider();
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: 16),
          NameField(controller: _usernameController,enable: true),
          const SizedBox(height: 16),
          PhoneNumberFieldForm(controller: _phoneController),
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
                return 'please_select_a_day'.tr();
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          AddressFieldWidget(controller: _addressController),
          const SizedBox(height: 16),
          DetailsField(controller: _detailsController),
          const SizedBox(height: 50),
          bloc.state.isLoading?CircularProgressIndicator():
          DefaultButton(
            onTap: () => _submitForm(context, bloc),
            height: 50,
            roundnessLevel: 12,
            content: Text(
              'submit_order'.tr(),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            backgroundColor: colorProvider.primary,
          ),
        ],
      ),
    );
  }
}
