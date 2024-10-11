import 'package:entregafinal/models/shipment.dart';
import 'package:entregafinal/screens/packageData.dart';
import 'package:flutter/material.dart';

class DeliveryCard extends StatelessWidget {
  final Shipment delivery;

  const DeliveryCard({
    super.key,
    required this.delivery,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text('Número de Rastreo: ${delivery.trackingNumber}'),
        subtitle: Column(
          children: [
            Text('Cliente: ${delivery.recipient.name}'),
            Text('Dirección: ${delivery.recipient.address?.formattedAddress}'),
          ]
        ),
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
