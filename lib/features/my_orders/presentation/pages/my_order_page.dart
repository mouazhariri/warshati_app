import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class MyOrdersPage extends StatelessWidget {
  const MyOrdersPage({super.key});

  final List<Map<String, dynamic>> orders = const [
    {
      "phone_number": "876876876",
      "address": "sss qudssssia",
      "service_day": "2025-04-29",
      "created_at": "2025-04-11T17:21:32.522088Z",
      "user": 2,
      "service": 1
    },
    {
      "phone_number": "123456789",
      "address": "New Street, NY",
      "service_day": "2025-04-20",
      "created_at": "2025-04-10T15:12:22.123456Z",
      "user": 3,
      "service": 2
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Sort the orders by service_day
    final sortedOrders = [...orders]
      ..sort((a, b) => a['service_day'].compareTo(b['service_day']));

    return Scaffold(
      body: ListView.builder(
        itemCount: sortedOrders.length,
        itemBuilder: (context, index) {
          final order = sortedOrders[index];
          final formattedDate = DateFormat('dd/ MM/ yyyy')
              .format(DateTime.parse(order['service_day']));
          final createdAt = DateFormat('yyyy-MM-dd – kk:mm')
              .format(DateTime.parse(order['created_at']));

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, color: Colors.teal),
                      const SizedBox(width: 8),
                      Text(
                        formattedDate,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const Divider(height: 20, thickness: 1.2),
                  buildInfoRow(Icons.phone, "Phone", order['phone_number']),
                  buildInfoRow(Icons.location_on, "Address", order['address']),
                  buildInfoRow(
                      Icons.person, "User ID", order['user'].toString()),
                  buildInfoRow(Icons.miscellaneous_services, "Service ID",
                      order['service'].toString()),
                  buildInfoRow(Icons.access_time, "Created At", createdAt),
                ],
              ),
            ),
          );
        },
      ),
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
