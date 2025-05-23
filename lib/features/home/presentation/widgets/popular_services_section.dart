import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sham/features/home/presentation/bloc/home_bloc.dart';
import 'package:sham/features/service_details/presentation/bloc/service_details_bloc.dart';
import 'package:sham/src/application/router/app_routes.dart';
import 'package:sham/src/core/utils/extenssion/widget_extensions.dart';
import 'package:sham/src/core/widgets/cached_image_widget.dart';
import 'package:sham/src/infrastructure/api/endpoint/base_urls.dart';

import '../../../../src/application/di/injection.dart';
import '../../../../src/resourses/color_manager/color_provider.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';

class PopularServicesSection extends StatefulWidget {
  const PopularServicesSection({super.key});

  @override
  State<PopularServicesSection> createState() => _PopularServicesSectionState();
}

class _PopularServicesSectionState extends State<PopularServicesSection> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    ColorProvider colorProvider = ColorProvider();
    BlocListener<ServiceDetailsBloc, ServiceDetailsState>(
        listener: (context, state) {
      if (state.success) {
        BotToast.showText(
          text: "order_success".tr(),
          textStyle: TextStyle(fontSize: 16, color: Colors.white),
          contentColor: Colors.green,
          borderRadius: BorderRadius.circular(8),
          duration: Duration(seconds: 3),
          align: Alignment.bottomCenter,
        );
      }
    });
    return Expanded(
              child: SingleChildScrollView(
        child: BlocProvider<HomeBloc>.value(
          value: BlocProvider.of<HomeBloc>(context),
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return state.isLoading
                  ? CircularProgressIndicator(
                      color: colorProvider.primary,
                    ).centered()
                  : Column(
                      children: [
                        30.verticalSpace,
                    
                        ListView.separated(
                            shrinkWrap: true,
                                                physics: const NeverScrollableScrollPhysics(),
                        
                            // scrollDirection: Axis.vertical,
                            itemCount: state.servicesList.length,
                            separatorBuilder: (context, index) => 16.verticalSpace,
                            itemBuilder: (context, index) {
                              final service = state.servicesList[index];
                              return GestureDetector(
                                onTap: () {
                                  context.pushNamed(
                                    AppRoutes.serviceDetails,
                                    extra: service,
                                  );
                                },
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: Colors.grey[300]!),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                          borderRadius: const BorderRadius.vertical(
                                            top: Radius.circular(12),
                                          ),
                                          child: CachedImageWidget(
                                            image: BaseUrls.baseUrl + service.image,
                                            height: 120,
                                            width: double.infinity,
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              service.title,
                                              style:
                                                  textTheme.displaySmall!.copyWith(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                            ),
                                            10.verticalSpace,
                                            Text(
                                              ' ${service.price}',
                                              style: textTheme.displaySmall!
                                                  .copyWith(
                                                      color: colorProvider.primary,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 12),
                                            ),
                                            10.verticalSpace,
                                            Text(
                                              service.description,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: textTheme.titleMedium!
                                                  .copyWith(
                                                      fontSize: 12,
                                                      color: colorProvider.dark),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        80.verticalSpace,
                      ],
                    );
            },
          ),
        ).symmetricPadding(horizontal: 16),
      ),
    );
  }
}
