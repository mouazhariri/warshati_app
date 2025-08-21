// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:sham/features/home/domain/entities/services_entity.dart';
import 'package:sham/features/home/presentation/bloc/home_bloc.dart';
import 'package:sham/features/service_details/presentation/bloc/service_details_bloc.dart';
import 'package:sham/features/service_details/presentation/widget/services_row_list_widget.dart';
import 'package:sham/src/application/di/injection.dart';
import 'package:sham/src/core/utils/constants/messages/app_messages.dart';

import '../../../../src/core/widgets/cached_image_widget.dart';
import '../../../../src/infrastructure/api/endpoint/base_urls.dart';
import '../widget/order_form_widget.dart';

class ServiceDetailsPage extends StatefulWidget {
  final ServicesEntity? services;

  const ServiceDetailsPage({
    super.key,
    required this.services,
  });

  @override
  State<ServiceDetailsPage> createState() => _ServiceDetailsPageState();
}

class _ServiceDetailsPageState extends State<ServiceDetailsPage> {
  late List<int> selectedServiceIds;

  @override
  void initState() {
    super.initState();
    // initialize once (DON'T mutate in build)
    selectedServiceIds = [
      if (widget.services != null) widget.services!.id,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ServiceDetailsBloc>(
      create: (context) => sl<ServiceDetailsBloc>(),
      child: BlocConsumer<ServiceDetailsBloc, ServiceDetailsState>(
        listener: (context, state) {
          if (state.success) {
            context.pop();
            AppMessages.showSuccess(
              message: "srvice_was_ordered_successfully".tr(),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.services?.title ?? "order_now".tr()),
            ),
            body: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SelectableServicesRow(
                      allServices: context.read<HomeBloc>().state.servicesList,
                      initiallySelectedServiceIds: [
                        if (widget.services != null) widget.services!.id
                      ],
                      onSelectionChanged: (ids) {
                        // keep state HERE, not in a Stateless field
                        setState(() => selectedServiceIds = List<int>.from(ids));
                        debugPrint("Selected IDs: $selectedServiceIds");
                      },
                    ),
                    20.verticalSpace,

                    if (widget.services != null) ...[
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                        child: CachedImageWidget(
                          image: BaseUrls.baseUrl + widget.services!.image,
                          height: 160,
                          width: double.infinity,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        widget.services!.description,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 24),
                    ],

                    Text(
                      "order_now".tr(),
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),

                    // IMPORTANT: pass the CURRENT state list, not an old reference
                    OrderFormWidget(
                      serviceId: widget.services?.id,
                      selectedIds: selectedServiceIds,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
