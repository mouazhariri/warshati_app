import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../src/core/widgets/cached_image_widget.dart';
import '../../../../src/infrastructure/api/endpoint/base_urls.dart';
import '../widget/order_form_widget.dart';

class ServiceDetailsPage extends StatelessWidget {
  final String serviceName;
  final String serviceImage;
  final String serviceDescription;

  const ServiceDetailsPage({
    super.key,
    required this.serviceName,
    required this.serviceImage,
    this.serviceDescription = "service_description",
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(serviceName),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Service image + title + description (mock)
              ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: CachedImageWidget(
                    image: BaseUrls.baseUrl + serviceImage,
                    height: 160,
                    width: double.infinity,
                  )),
              const SizedBox(height: 16),
              // Text(
              //   serviceName,
              //   style: Theme.of(context)
              //       .textTheme
              //       .headlineSmall
              //       ?.copyWith(fontWeight: FontWeight.bold),
              // ),
              // const SizedBox(height: 8),
              Text(
                serviceDescription,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),

              // Order now + Form
              Text(
                "order_now".tr(),
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              const OrderFormWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
