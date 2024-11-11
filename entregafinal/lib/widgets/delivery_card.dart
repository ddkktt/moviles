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
      color: Theme.of(context).colorScheme.primary,
      child: ListTile(
        title: Center(
          child: Text(
            delivery.recipient.name,
            style: TextStyle(
              fontSize: 25,
              color: Theme.of(context).colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: 
              TextSpan(
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,       
                  fontSize: 20,
                ),
                children: [
                  const TextSpan(
                    text: 'Tracking Number: ',
                    style: TextStyle(fontWeight: FontWeight.bold)
                  ),
                  TextSpan(
                    text: delivery.trackingNumber,
                  ),
                ]
              ),
            ),
            RichText(
              text: 
              TextSpan(
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 20,
                ),
                children: [
                  const TextSpan(
                    text: 'Dirección: ',
                    style: TextStyle(fontWeight: FontWeight.bold)
                  ),
                  TextSpan(
                    text: delivery.recipient.address?.formattedAddress,
                  ),
                ]
              ),
            ),
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
