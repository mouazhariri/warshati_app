import 'package:flutter/material.dart';

class ServiceDetailsPage extends StatelessWidget {
  final String serviceName;

  const ServiceDetailsPage({
    super.key,
    required this.serviceName,
  });

  @override
  Widget build(BuildContext context) {
    // Mock data for service providers
    final List<Map<String, dynamic>> serviceProviders = [
      {
        'name': 'Michel Smith',
        'service': 'Painters',
        'rating': 3.5,
        'price': '₹450/hr',
        'image': 'assets/images/service_provider1.jpg',
      },
      {
        'name': 'John Carter',
        'service': 'Painters',
        'rating': 4.5,
        'price': '₹500/hr',
        'image': 'assets/images/service_provider2.jpg',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(serviceName),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: serviceProviders.length,
        itemBuilder: (context, index) {
          final provider = serviceProviders[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      provider['image'],
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          provider['name'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          provider['service'],
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  size: 16,
                                  color: Colors.amber,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  provider['rating'].toString(),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Text(
                              provider['price'],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Implement booking functionality
                    },
                    child: const Text('Book'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
} 