import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sham/features/home/domain/entities/services_entity.dart';
import 'package:sham/features/home/presentation/bloc/home_bloc.dart';
import 'package:sham/features/service_details/presentation/bloc/service_details_bloc.dart';
import 'package:sham/features/service_details/presentation/widget/services_row_list_widget.dart';
import 'package:sham/src/application/di/injection.dart';
import '../../../../src/core/widgets/cached_image_widget.dart';
import '../../../../src/infrastructure/api/endpoint/base_urls.dart';
import '../widget/order_form_widget.dart';

class ServiceDetailsPage extends StatelessWidget {
  final ServicesEntity? services;

   ServiceDetailsPage({super.key, required this.services});
List<int> selectedIds=[];
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ServiceDetailsBloc>(
      create: (context) => sl<ServiceDetailsBloc>(),
      child: BlocBuilder<ServiceDetailsBloc, ServiceDetailsState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(services?.title??"order_now".tr()),
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
  initiallySelectedServiceIds: services != null ? [services!.id] : [],
  onSelectionChanged: (selectedIds) {
    selectedIds=selectedIds;
    // You can update the UI or call fetch logic with selected service IDs
    print("Selected IDs: $selectedIds");
  },
),
20.verticalSpace,

                    // Service image + title + description 
               if(services!=null)
                    Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                            child: CachedImageWidget(
                              image: BaseUrls.baseUrl + services!.image,
                              height: 160,
                              width: double.infinity,
                            )),
                        const SizedBox(height: 16),
                        Text(
                          services!.description,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),

                    Text(
                      "order_now".tr(),
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),

                    OrderFormWidget(
                      serviceId: services?.id,
                      selectedIds:selectedIds,
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
