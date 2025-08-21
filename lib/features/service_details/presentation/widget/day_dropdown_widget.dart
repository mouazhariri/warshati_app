import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DayDropdownWidget extends StatelessWidget {
  final String? selectedDay;
  final ValueChanged<String?> onChanged;
  final FormFieldValidator<String>? validator;

  DayDropdownWidget({
    super.key,
    required this.selectedDay,
    required this.onChanged,
    this.validator,
  });
  final List<String> days = [
    "sunday",
    "monday",
    "tuesday",
    "wednsday",
    "thursday",
    "friday",
    "saturday",
    "nearest_time",
    "other"
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "date".tr(),
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
        ),
        12.verticalSpace,
        DropdownButtonFormField<String>(
          value: selectedDay,
          decoration: InputDecoration(
            labelText: 'preferred_day'.tr(),
            labelStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            prefixIcon: const Icon(Icons.calendar_today),
          ),
          items: days
              .map(
                (data) => DropdownMenuItem(value: data, child: Text(data.tr())),
              )
              .toList(),
          // [
          //   DropdownMenuItem(value: 'sunday', child: Text('sunday'.tr())),
          //   DropdownMenuItem(value: 'monday', child: Text('monday'.tr())),
          //   DropdownMenuItem(value: 'tuesday', child: Text('tuesday'.tr())),
          //   DropdownMenuItem(
          //       value: 'nearest_time', child: Text('nearest_time'.tr())),
          // ],
          onChanged: onChanged,
          validator: validator,
        ),
      ],
    );
  }
}
