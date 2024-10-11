import 'package:entregafinal/screens/packageData.dart';
import 'package:flutter/material.dart';

class DeliveryCard extends StatelessWidget {
  final delivery;
  const DeliveryCard({
    super.key,
    required this.delivery
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: const Text('Mis paquetes'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PackageDataScreen(delivery: delivery),
            ),
          );
        },
      ),
    );
  }
}
