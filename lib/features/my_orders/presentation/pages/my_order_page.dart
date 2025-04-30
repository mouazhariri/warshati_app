import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sham/features/my_orders/presentation/bloc/my_orders_bloc.dart';
import 'package:sham/features/my_orders/presentation/bloc/my_orders_event.dart';
import 'package:sham/features/my_orders/presentation/bloc/my_orders_state.dart';
import 'package:sham/src/application/di/injection.dart';
import 'package:sham/src/core/utils/extenssion/widget_extensions.dart';
import 'package:sham/src/resourses/color_manager/color_provider.dart';

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({super.key});

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
    final MyOrdersBloc bloc=sl<MyOrdersBloc>();
  @override
  void initState() {
bloc.add(GetMyOrdersEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    ColorProvider colorProvider = ColorProvider();

    return BlocBuilder<MyOrdersBloc, MyOrdersState>(
      bloc: bloc,
      builder: (context, state) {
    //      final sortedOrders = [...state.myOrders]
    // ..sort((a, b) => a.serviceDay.compareTo(b.serviceDay));
        return state.isLoading
            ? CircularProgressIndicator(
                color: colorProvider.primary,
              ).centered()
            :  Scaffold(
          body: ListView.builder(
            itemCount: state.myOrders.length,
            itemBuilder: (context, index) {
              final order = state.myOrders[index];
              // final formattedDate = DateFormat('dd/ MM/ yyyy')
              //     .format(DateTime.parse(order.serviceDay));
              final createdAt = DateFormat('yyyy-MM-dd – kk:mm')
                  .format(DateTime.parse(order.createAt));
    
              return Card(
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.calendar_today,
                              color: Colors.teal),
                          const SizedBox(width: 8),
                          Text(
                            order.serviceDay,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Divider(
                        height: 15,
                        thickness: 0.8,
                        color: colorProvider.greyBorder,
                      ),
                      buildInfoRow(
                          Icons.phone, context.tr("phoneNumber"), order.phoneNumber),
                      buildInfoRow(
                          Icons.location_on, context.tr("address"), order.address),
                      buildInfoRow(
                          Icons.person, context.tr("user_name"), order.userName.toString()),
                      buildInfoRow(Icons.miscellaneous_services, context.tr("service_name"),
                          order.serviceTitle.toString()),
                      buildInfoRow(
                          Icons.access_time, context.tr("created_at"), createdAt),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[600], size: 20),
          const SizedBox(width: 8),
          Text(
            "$label: ",
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.black87),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
